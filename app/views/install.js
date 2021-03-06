// vim: ts=4:sw=4:expandtab
/* global QRCode relay */

(function () {
    'use strict';

    self.F = self.F || {};

    F.InstallView = F.View.extend({
        initialize: function(options) {
            this.accountManager = options.accountManager;
            this.registered = options.registered;
        },

        render: async function() {
            await F.View.prototype.render.call(this);
            if (this.registered) {
                this.$('#f-already-registered').removeClass('hidden');
            }
            this.clearQR();
            this.$progress = this.$('.ui.progress');
            this.selectStep('start');
            return this;
        },

        clearQR: function() {
            this.$('#qr').text('Connecting...');
        },

        onProvisionReady: async function(uuid, key) {
            this.$('#qr').html('');
            const url = `tsdevice://?uuid=${encodeURIComponent(uuid)}&` +
                                    `pub_key=${encodeURIComponent(key)}`;
            new QRCode(this.$('#qr')[0]).makeCode(url);
            console.info('/link ' + url);
            if (!this.registered) {
                console.info("Issuing auto provision request...");
                try {
                    await relay.hub.fetchAtlas('/v1/provision/request', {
                        method: 'POST',
                        json: {uuid, key}
                    });
                } catch(e) {
                    console.warn("Ignoring provision request error:", e);
                }
            }
        },

        onConfirmAddress: async function(addr) {
            if (addr !== F.currentUser.id) {
                await F.util.promptModal({
                    icon: 'red warning sign',
                    header: 'User Identity Mismatch',
                    content: 'You must be logged into Forsta using the same user identity ' +
                             'on both devices.'
                });
                location.reload();
                await relay.util.never();  // location.reload is non-blocking.
            }
            this.selectStep('sync');
        },

        onKeyProgress: function(i) {
            // Arbitrarily allocate 80% of progress bar to key generation.  Save 20% for DB cooldown.
            this.$progress.progress({percent: i * 0.80});
        },

        cooldown: async function() {
            /* The register*Device funcs return prematurely.  The storage system
             * is asynchronous.  We need a UX timing hack to dance around it. */
            const cooldown = 2; // seconds
            for (let i = 80; i <= 100; i++) {
                this.$progress.progress({percent: i});
                await relay.util.sleep(cooldown / 20);
            }
            await relay.util.sleep(1);
            location.assign(F.urls.main);
            await relay.util.never();  // location.assign is non-blocking.
        },

        selectStep: function(id, completed) {
            const panel = this.$(`.panel[data-step="${id}"]`);
            panel.siblings().removeClass('active');
            panel.addClass('active');
            const step = this.$(`.step[data-step="${id}"]`);
            const sibs = step.siblings();
            const behind = step.prevAll();
            const ahead = step.nextAll();
            sibs.removeClass('active');
            sibs.addClass('disabled');
            behind.addClass('completed');
            ahead.removeClass('completed');
            step.addClass('active');
            step.removeClass('disabled');
            if (completed) {
                step.addClass('completed');
            }
        },

        showModal: function($el, closable) {
            $el.modal({closable: !!closable}).modal('show');
        },

        showTooManyDevices: function() {
            this.showModal($('#f-too-many-devices'));
        },

        showConnectionError: function() {
            this.showModal($('#f-connection-error'));
        },

        loop: async function() {
            const name = F.foundation.generateDeviceName();
            while (true) {
                const job = await this.accountManager.registerDevice(name,
                    this.onProvisionReady.bind(this),
                    this.onConfirmAddress.bind(this),
                    this.onKeyProgress.bind(this));
                try {
                    if (await Promise.race([job.done, relay.util.sleep(120)]) !== 120) {
                        await this.cooldown();
                        return;
                    }
                } catch(e) {
                    if (e.message === 'websocket closed') {
                        this.showConnectionError();
                        await relay.util.sleep(300);
                        location.reload();
                    } else if (e instanceof relay.ProtocolError && e.code == 411) {
                        this.showTooManyDevices();
                    } else {
                        throw e;
                    }
                    return;
                }
            }
        }
    });
})();
