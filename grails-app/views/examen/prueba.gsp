
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

Camvas para cargar la imagen
<canvas id="myCanvas" width="800" height="600"></canvas>


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

        image.src = 'https://escueladelamemoria.com/wp-content/uploads/2016/11/examen2.jpg'; // Reemplaza con la ruta de tu imagen

        image.onload = function() {
            // Dibujar la imagen en el canvas
            ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

            // Dibujar las marcas
            drawMark(ctx, 100, 100, "Marca 1");
            drawMark(ctx, 200, 200, "Marca 2");
            drawMark(ctx, 300, 300, "Marca 3");
        };

        function drawMark(ctx, x, y, text) {
            // Configurar estilo de la marca
            ctx.fillStyle = '#f08080';
            ctx.strokeStyle = 'black';
            ctx.lineWidth = 2;

            // Dibujar círculo
            ctx.beginPath();
            ctx.arc(x, y, 10, 0, Math.PI * 2);
            ctx.fill();
            ctx.stroke();

            // Dibujar texto
            ctx.fillStyle = '#4080d0';
            ctx.font = '900 18px Arial';
            ctx.fillText(text, x + 15, y + 5);
        }
    });
</script>

</body>
</html>