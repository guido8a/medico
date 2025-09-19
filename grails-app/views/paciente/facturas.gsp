<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de facturas
    </title>

    <style>

        .tamano{
            font-size: 16px;
        }

        .bd{
            font-weight: bold;
        }

    </style>
</head>

<body>


<div id="divEmpresa">

</div>

<div id="divPersona">

</div>

<div id="divFactura">

</div>

<div id="divLibretin">

</div>

<div id="divFormaDePago">

</div>


<script type="text/javascript">

    cargarDatosEmpresa();
    cargarDatosFactura();
    cargarDatosLibretin();
    cargarDatosPersona();
    cargarFormaDePago();

    function cargarDatosEmpresa() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'datosEmpresaFactura_ajax')}',
            data: {
                id: '${empresa?.id}'
            },
            success: function (msg) {
                d.modal("hide");
                $("#divEmpresa").html(msg)
            }
        })
    }

    function cargarDatosFactura() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'datosFactura_ajax')}',
            data: {
                id: '${empresa?.id}'
            },
            success: function (msg) {
                d.modal("hide");
                $("#divFactura").html(msg)
            }
        })
    }

    function cargarDatosLibretin() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'datosLibretin_ajax')}',
            data: {
                id: '${empresa?.id}'
            },
            success: function (msg) {
                d.modal("hide");
                $("#divLibretin").html(msg)
            }
        })
    }

    function cargarDatosPersona() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'datosPersona_ajax')}',
            data: {
                id: '${paciente?.id}'
            },
            success: function (msg) {
                d.modal("hide");
                $("#divPersona").html(msg)
            }
        })
    }

    function cargarFormaDePago() {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'formaDePago_ajax')}',
            data: {

            },
            success: function (msg) {
                d.modal("hide");
                $("#divFormaDePago").html(msg)
            }
        })
    }

</script>

</body>
</html>