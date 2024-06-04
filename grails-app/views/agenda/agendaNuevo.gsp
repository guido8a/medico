
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Agendamiento
    </title>
</head>
<body>


<div>
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-3">
                    <label class="control-label text-info">Paciente</label>
                    <g:select name="paciente" class="col-md-12 form-control" from="${seguridad.Paciente.list().sort{it.apellido}}" optionKey="id"
                              optionValue="${{it.apellido + " " + it.nombre}}"/>
                </span>
            </span>
            <span class="grupo">
                <span class="col-md-3">
                    <label class="control-label text-info">Doctor</label>
                    <g:select name="doctor" class="col-md-12 form-control" from="${seguridad.Persona.list().sort{it.apellido}}" optionKey="id"
                              optionValue="${{it.apellido + " " + it.nombre}}"/>
                </span>
            </span>
            <span class="grupo">
                <span class="col-md-3">
                    <label class="control-label text-info">Fecha</label>
                    <input aria-label="" name="fecha" id='fecha' type='text' class="form-control" value="${new Date()?.format("dd-MM-yyyy")}" />
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnAgendar"><i class="fa fa-check"></i> Seleccionar</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaAgendamiento" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">

    $('#fecha').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    cargarTablaAgendamiento(null)

    $("#btnAgendar").click(function () {
        cargarTablaAgendamiento('1');
    });

    function cargarTablaAgendamiento(tipo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'agenda', action: 'tablaAgendamiento_ajax')}',
            data:{
                tipo: tipo
            },
            success: function (msg){
                $("#divTablaAgendamiento").html(msg)
            }
        })
    }


</script>

</body>
</html>
