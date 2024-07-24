<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Agenda</title>

    <style type="text/css">
    .gestion > td {
        /*background-color: #ff8080;*/
        background-color: #edc384;
        color: #0c0460;
    }

    .normal > td {
        background-color: #d7dff9;
        color: #0c3440;
    }
    .agendado {
        text-align: left !important;
        background-color: #a6b5cf;
    }
    .libre {
        color: #606060;
    }
    .clase_hoy {
        text-align: center !important;
        background-color: #7380b3;
        /*background-color: #133053;*/
    }
    .horas {
        text-align: center !important;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
        color: #0070B0;
        margin-top: 15px;
        text-align: center;
    }
    </style>

</head>

<body>


<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="col-md-2">
            <a href="${createLink(controller: 'paciente', action: 'historial')}/${paciente}"  class="btn btn-sm btn-info"
               style="float: left; margin-top: 25px" title="Retornar a historial del paciente">
                <i class="fas fa-arrow-left"></i> Regresar
            </a>
    </div>

    <div class="col-md-6">
    <h3 class="titl" style="margin-top: 5px">Agenda general Consultorio: <span style="color: #aa7700">${consultorio?.nombre}</span></h3>
    </div>

    <div class="col-md-2">
        <label for="fecha" class="col-md-12 control-label" style="text-align: left">
            Seleccione la Fecha
        </label>
        <input aria-label="" name="fecha" id='fecha' type='text' class="form-control" value="${new Date()?.format("dd-MM-yyyy")}" />
    </div>

</div>

<div id="divTabla">

</div>



<script type="text/javascript">
    var id = null;

    $('#fecha').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    }).on('dp.change', function(e){
        var fecha = $('#fecha').val();
        var doctor = $("#doctor option:selected").val();
//        console.log('cambia', fecha);
        cargaTabla(1, doctor);
    });

    cargaTabla();

    function cargaTabla() {
        var fecha = $('#fecha').val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'agenda', action:'tabla_agnd_ajax')}",
            data: {
                fecha: fecha
            },
            success: function (msg) {
                $("#divTabla").html(msg);
                $("#divTabla").focus();
            } //success
        });
        //location.reload()//ajax
    }// /createEdit

    $("#semana").change(function () {
        var semana = $(this).val();
        var doctor = $("#doctor option:selected").val();
        cargaTabla(semana, doctor);
    });

</script>

</body>
</html>
