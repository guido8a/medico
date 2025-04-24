<div style="height: 700px; overflow: auto">
    <canvas id="myCanvas" width="800" height="1200"></canvas>
</div>

<script type="text/javascript">

    // document.addEventListener("DOMContentLoaded", function() {
    const canvas = document.getElementById('myCanvas');
    const ctx = canvas.getContext('2d');
    const image = new Image();

    image.src = "${createLink(controller: "examen", action: "getImage2")}"

    console.log('ancho', "${ancho}")
    image.onload = function() {
        // Dibujar la imagen en el canvas
        ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

        // Dibujar las marcas
//            drawMark(ctx, 110, 83, "Tope");
//            drawMark(ctx, 110, 1063, "Origen2");
//            drawMark(ctx, 110, 1027, "Origen");
//            drawMark(ctx, 110, 841, "Origen3");
//            drawMark(ctx, 110, 808, "Origen4");
//            drawMark(ctx, 691, 1063, "Final");

        %{--drawMark(ctx, ${edad}, ${data.exfstlla}, "Estatura");--}%
        %{--drawMark(ctx, ${edad}, ${data.exfspeso}, "Peso");--}%
        %{--texto(ctx, 350, 260, "${data.exfs_imc}");--}%


        %{--console.log('data:', "${jdata}" )--}%
        var js_data = "${jdata}";
        js_data = js_data.replaceAll("&quot;", '"');
        const dt = JSON.parse(js_data);
        // console.log('data:', dt[0] )

        %{--texto(ctx, 350, 260, "${data.exfs_imc}");--}%

        for (var i=0; i < dt.length; i++) {
            drawMark(ctx, dt[i].edad, dt[i].exfstlla, "");
            drawMark(ctx, dt[i].edad, dt[i].exfspeso, "");
        }

    };

    function drawMark(ctx, x, y, text) {
        // Configurar estilo de la marca
        ctx.fillStyle = '#40d020';
        ctx.strokeStyle = 'black';
        ctx.lineWidth = 1;

        // Dibujar círculo
        ctx.beginPath();
        ctx.arc(x, y, 3, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();

        // Dibujar texto
        ctx.fillStyle = '#003070';
        ctx.font = '600 18px Arial';
        ctx.fillText(text, x + 11, y + 7);
    }

    function texto(ctx, x, y, text) {
        // Dibujar texto
        ctx.fillStyle = '#003070';
        ctx.font = '900 18px Arial';
        ctx.fillText(text, x, y);
    }
    // });
</script>

%{--</body>--}%
%{--</html>--}%