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

<a href="#" id="btnEnviarFactura" class="btn btn-info" title="Enviar factura al SRI"
   style="border-style: solid; border-color: #d05a05; border-width: 1px; margin-right: 1px">
    <i class="fa fa-plane"></i>
    Factura a SRI
</a>



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


    $("#btnEnviarFactura").click(function () {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> Está seguro que desea enviar esta factura al SRI?", function (result) {
            if (result) {
                openLoader('Enviando al SRI...');
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'servicioSri', action: 'facturaElectronica')}',
                    data:{
                        id: '${proceso?.id}'
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            closeLoader();
                            log("Factura enviada al SRI correctamente!","success");
                            setTimeout(function () {
                                location.href="${createLink(controller: 'proceso', action: 'nuevoProceso')}/?id=" + '${proceso?.id}'
                            }, 800);
                        }else{
                            closeLoader();
                            log("Error al enviar la factura al SRI","error");
                        }
                    }
                });
            }
        })
    });


</script>

</body>
</html>