<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

        <title>Install - Forsta</title>

        <link rel="manifest" href="/@static/manifest.json?v={{version}}"/>
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i&subset=latin-ext"/>
        <link id="favicon" rel="shortcut icon" href="/@static/images/icon_256.png?v={{version}}"/>
        <link rel="stylesheet" type="text/css" href="/@static/semantic/semantic.css?v={{version}}"/>
        <link rel="stylesheet" type="text/css" href="/@static/stylesheets/install.css?v={{version}}"/>

        <script type="text/javascript" src="/@env.js"></script>
        <script type="text/javascript" src="/@static/js/app/deps.js?v={{version}}"></script>
        <script type="text/javascript" src="/@static/semantic/semantic.js?v={{version}}"></script>
    </head>

    <body>
        <div id="f-too-many-devices" class="ui modal">
            <div class="header">
                Too many devices
            </div>
            <div class="image content">
                <div class="image"><i class="icon warning sign"></i></div>
                <div class="description">
                    Please remove one or more of your devices from the mobile
                    App and try again.
                </div>
            </div>
        </div>

        <div id="f-connection-error" class="ui modal">
            <div class="header">
                Connection Error
            </div>
            <div class="image content">
                <div class="image"><i class="icon warning sign"></i></div>
                <div class="description">
                    Sorry but there was a connection error.  Please try again later.
                </div>
            </div>
        </div>

        <main class="ui container segment raised">
            <h1 class="ui header">
                <img src="/@static/images/icon_128.png?v={{version}}"/>
                <div class="content">
                    Forsta Messenger Install
                    <div class="sub header">
                        To authenticate your identity Forsta Messenger must first be verified using your mobile device.
                    </div>
                  </div>
                </div>
            </h1>

            <div class="ui attached segment blue">
                <div class="panel" data-step="start">
                    <div id="f-already-registered" class="ui message top warning hidden">
                        <i class="icon warning sign"></i>
                        This computer appears to already be registered.
                        <a href="/@">Click here to return to the messenger app</a> if you
                        reached this page mistakenly.
                    </div>

                    <div class="ui grid stackable">
                        <div class="column ten wide ui segment apps basic">
                            To use the Forsta Messenger you first need to install one of the mobile Apps.
                            This is to certify your identity on both platforms.
                            <div class="ui grid two column">
                                <div class="column centered">
                                    <a class="ui image badge" target="_blank"
                                       href="https://play.google.com/store/apps/details?id=io.forsta.relay&ah=p2dRwy36aXoF7mAqbP3TBYqi8YU">
                                        <img src="@static/images/google-play-badge.png?v={{version}}"/>
                                    </a>
                                </div>
                                <div class="column centered">
                                    <a class="ui image badge" target="_blank"
                                       href="mailto:support@forsta.io?subject=Apple%20App%20Request">
                                        <img src="@static/images/apple-app-store-badge.svg?v={{version}}"/>
                                    </a>
                                </div>
                            </div>

                            <h5 class="ui header">How to user this QR code</h5>
                            <ol>
                               <li>Open the Forsta app on your phone</li>
                               <li>Navigate to: <span id="qr-code-links">Link to Web App</span> in dropdown menu</li>
                               <li>Tap the button to add a new device and scan this QR code.</li>
                            </ol>
                        </div>

                        <div class="column six wide ui segment basic" id="qr"></div>
                    </div>
                </div>

                <div class="panel" data-step="sync">
                    <h3 class="ui header">
                        <i class="icon hourglass half"></i>
                        <div class="content">
                            Generating Keys
                            <div class="sub header">
                                Creating security keys for this device...
                            </div>
                        </div>
                    </h3>

                    <div class="ui progress">
                        <div class="bar">
                            <div class="progress"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ui steps four attached bottom mini">
                <div class="step" data-step="start">
                    <i class="icon qrcode"></i>
                    <div class="content">
                        <div class="title">Scan QR Code</div>
                        <div class="description">Verify this computer</div>
                    </div>
                </div>
                <div class="step" data-step="sync">
                    <i class="icon handshake"></i>
                    <div class="content">
                        <div class="title">Generate Keys</div>
                        <div class="description">Create unique security keys for this computer.</div>
                    </div>
                </div>
            </div>
        </main>
        <a style="position: fixed; padding: 0.5em; margin: 0.5em; right: 0; bottom: 0; opacity: 0.80;"
           href="#" onclick="F.easter.registerAccount()">π</a>
    </body>

    <script type="text/javascript" src="/@static/js/lib/signal.js?v={{version}}"></script>
    <script type="text/javascript" src="/@static/js/lib/textsecure.js?v={{version}}"></script>
    <script type="text/javascript" src="/@static/js/app/install.js?v={{version}}"></script>
</html>