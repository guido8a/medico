
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de citas del paciente: '${paciente?.apellido + " " + paciente?.nombre}'
    </title>
</head>
<body>

<h3>
    <g:if test="${paciente?.id}">
        Citas del Paciente: <strong style="font-style: italic"> ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '')}</strong>
    </g:if>
</h3>

<div class="row" style="margin-bottom: 10px">
    <div class="span9 btn-group" role="navigation">
        <a href="#" class="btn btn-success btnNuevaCita">
            <i class="fa fa-file"></i>
            Nueva cita
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaHistorial" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;

    $(".btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}'
    });

    cargarTablaCitas();

    function cargarTablaCitas() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'historial', action: 'tablaCitas_ajax')}',
            data:{
                id: '${paciente?.id}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaHistorial").html(msg)
            }
        })
    }

 </script>

</body>
</html>
