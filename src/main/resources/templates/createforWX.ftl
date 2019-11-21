<!DOCTYPE HTML>
<html>
<head>
    <title>支付</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>
<body>
    <div id="myQrcode">
    </div>

    <!-- jquery -->
    <script src="https://cdn.bootcss.com/jquery/1.5.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>

    <script>
        jQuery('#myQrcode').qrcode({
            text	: "${codeUrl}"
        });
    </script>
</body>

</html>