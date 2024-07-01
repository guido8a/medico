
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Prueba</title>
</head>
<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <g:link controller="inicio" action="parametros" class="btn btn-primary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>
    <div class="btn-group">
        <g:link action="form" class="btn btn-success btnCrear">
            <i class="fa fa-clipboard-list"></i> Nuevo Examen
        </g:link>
    </div>
</div>

%{--<img src="${createLink(controller: "examen", action: "getImage")}" style="margin-top: 10px"/>--}%

Canvas para cargar la imagen
<canvas id="myCanvas" width="800" height="1200"></canvas>
%{--<canvas id="myCanvas" width="1597" height="2013"></canvas>--}%


<script type="text/javascript">
    $(".btnCrear").click(function() {
        createEditRow();
        return false;
    });

    $(".btnEditarExamen").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarExamen").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    document.addEventListener("DOMContentLoaded", function() {
        const canvas = document.getElementById('myCanvas');
        const ctx = canvas.getContext('2d');
        const image = new Image();

        // image.src = 'https://escueladelamemoria.com/wp-content/uploads/2016/11/examen2.jpg'; // Reemplaza con la ruta de tu imagen

        %{--image.src="${request.contextPath}/principal/getImgnProd?ruta=levis1.png&tp=v&id=0"/>--}%
        image.src = "${createLink(controller: "examen", action: "getImage")}"

        console.log('ancho', "${ancho}")
        image.onload = function() {
            // Dibujar la imagen en el canvas
            ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

            // Dibujar las marcas
//            drawMark(ctx, 108, 83, "Tope");
//            drawMark(ctx, 108, 1027, "Origen");
//            drawMark(ctx, 108, 1027, "Origen");
//            drawMark(ctx, 108, 997, "Origen");
//            drawMark(ctx, 108, 841, "Origen2");
//            drawMark(ctx, 108, 810, "Origen3");
//            drawMark(ctx, 690, 1053, "Final");

            drawMark(ctx, ${edad}, ${data.exfstlla}, "Estatura");
            drawMark(ctx, ${edad}, ${data.exfspeso}, "Peso");
            texto(ctx, 350, 260, "${data.exfs_imc}");
        };

        function drawMark(ctx, x, y, text) {
            // Configurar estilo de la marca
            ctx.fillStyle = '#80d080';
            ctx.strokeStyle = 'black';
            ctx.lineWidth = 2;

            // Dibujar círculo
            ctx.beginPath();
            ctx.arc(x, y, 7, 0, Math.PI * 2);
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
    });
</script>

</body>
</html>
