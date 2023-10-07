<!DOCTYPE html>

<html lang="ko">
  <head>
    <title>주소 찾기</title>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width,height=device-height,initial-scale=1.0"
    />
  </head>
  <body onload="execDaumPostcode()">
    <div
      id="layer"
      style="display:block; position:absolute; overflow:hidden; z-index:1; -webkit-overflow-scrolling:touch; "
    ></div>
    <script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
    <script>
      window.addEventListener("message", onReceivedPostMessage, false);

      function onReceivedPostMessage(event) {
        //..ex deconstruct event into action & params
        var action = event.data.action;
        var params = event.data.params;
        console.log("onReceivedPostMessage " + event);
      }

      function onReceivedActivityMessageViaJavascriptInterface(json) {
        //..ex deconstruct data into action & params
        var data = JSON.parse(json);
        var action = data.action;
        var params = data.params;
        console.log("onReceivedActivityMessageViaJavascriptInterface " + event);
      }

      function postMessageToiOS(postData) {
        window.webkit.messageHandlers.callBackHandler.postMessage(postData);
      }

      var element_layer = document.getElementById("layer");
      function execDaumPostcode() {
        new daum.Postcode({
          oncomplete: function (data) {
            var jibunAddress = "";

            if (data.jibunAddress == "") {
              jibunAddress = data.autoJibunAddress;
            } else if (data.autoJibunAddress == "") {
              jibunAddress = data.jibunAddress;
            }

            var postData = {
              roadAddress: data.roadAddress,
              jibunAddress: jibunAddress,
              zonecode: data.zonecode,
            };
            window.postMessageToiOS(postData);
          },
          width: "100%",
          height: "100%",
        }).embed(element_layer);
        element_layer.style.display = "block";
        initLayerPosition();
      }

      function initLayerPosition() {
        var width = window.innerWidth || document.documentElement.clientWidth;
        var height =
          window.innerHeight || document.documentElement.clientHeight;
        element_layer.style.width = width + "px";
        element_layer.style.height = height + "px";
        element_layer.style.left =
          ((window.innerWidth || document.documentElement.clientWidth) -
            width) /
            2 +
          "px";
        element_layer.style.top =
          ((window.innerHeight || document.documentElement.clientHeight) -
            height) /
            2 +
          "px";
      }
    </script>
  </body>
</html>
