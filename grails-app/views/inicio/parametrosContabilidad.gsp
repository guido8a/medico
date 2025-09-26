<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Parámetros</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 450px;
    }

    .tab-content {
        background    : #EEEEEE;
        border-left   : solid 1px #DDDDDD;
        border-bottom : solid 1px #DDDDDD;
        border-right  : solid 1px #DDDDDD;
        padding-top   : 10px;
    }

    .descripcion {
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
        border-radius: 4px;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 800px;
        text-align: justify;
    }

    .right {
        width       : 300px;
        margin-left : 20px;
        padding: 20px;
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .tam{
        font-size: 14px;
    }

    .tamano{
        font-size: 16px;
        color: #0c6cc2;
    }

    .titulo{
        font-size: 14px;
        color: #f8f9ff;
    }
    </style>

</head>

<body>

<g:set var="iconGen" value="fa fa-cog"/>
<g:set var="iconEmpr" value="fa fa-building-o"/>
<g:set var="iconAct" value="fa fa-laptop"/>
<g:set var="iconNom" value="fa fa-users"/>


<ul class="nav nav-pills" style="margin-top: 20px">
    <li class="active titulo"><a data-toggle="pill" href="#generales">Contable</a></li>
        <li class="titulo"><a data-toggle="pill" href="#empresa">Empresa</a></li>
        <li class="titulo"><a data-toggle="pill" href="#sri">Datos SRI / ATS</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content ui-corner-bottom tam">
    <div class="tab-pane fade in active" id="generales">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="nivel">
                        <g:link controller="nivel" action="list" class="tamano"> Nivel
                        </g:link>
                        de detalle de las cuentas contables y de  presupuesto (partidas)
                    </span>
                    <div class="descripcion hide">
                        <h4>Nivel</h4>
                        <p>Nivel de detalle de las cuentas contables y de las partidas presupuestarias.</p>
                        <p>Se aplica al plan o catálogo de cuentas y al catálogo presupuestario</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoPago">
                        <g:link controller="tipoPago" action="list" class="tamano">Tipo de pago</g:link> o forma de pago
                        que se acuerda con los proveedores, puede ser contado, crédito, o mediante un tiempo de espera antes
                        de realizar la efectivización del pago, ejemplo tarjetas de crédito con fechas de corte prefijadas
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Pago</h4>

                        <p>Es la forma de pago que se acuerda con los proveedores, puede ser contado, a crédito, o mediante un
                        tiempo de espera o fecha prefijada para la realización del pago, ejemplo tarjetas de crédito con fechas
                        de corte a inicio o fin de mes</p>

                        <p>Finix ha dejado abierta la posibilidad de manejar cortes y políticas de pago para aplicars a productos
                        como tarjetas de crédito</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="fuente">
                        <g:link controller="fuente" action="list" class="tamano">Fuente de transacciones</g:link> nombre de los módulos
                        del sistema que pueden generar transacciones contables
                    </span>

                    <div class="descripcion hide">
                        <h4>Fuente de Transacciones</h4>
                        <p>Define el origen de la transacción que genera el registro contable. Cada fuente está ligada a una
                        operación bancaria o a un módulo finix</p>
                        <p>Se aplica al registro contable de transacciones bancarias y a los módulos administrativos que puede
                        tener finix</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoDocPago">
                        <g:link controller="tipoDocumentoPago" action="list" class="tamano">Forma de Pago</g:link> para
                        el registro de la forma de pago a proveedores y clientes.
                    </span>
                    <div class="descripcion hide">
                        <h4>Tipo de Documento de Pago</h4>

                        <p>Documento de pago de obligaciones de cuentas por pagar o cuentas por cobrar. Forma de
                        pago.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoComprobante">
                        <g:link controller="tipoComprobante" action="list" class="tamano">Tipos de comprobante contable</g:link> usualmente
                        se trata de ingresos, egresos y diarios
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Comprobante</h4>
                        <p>En forma general los comprobantes contables son ingresos, egresos y diarios</p>
                        <p>Se deja abierta la posibilida de aplicar otros tipos de comprobantes de acuerdo a los requerimientos
                        que pueda hacer la Superintendencia de Bancos y Seguros</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoCuenta">
                        <g:link controller="tipoCuenta" action="list" class="tamano">Tipo de cuenta bancaria</g:link> que puede estar
                        asociada a una cuenta contable, por ejemplo caja bancos está asociada a una cuenta corriente
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Cuenta Bancaria</h4>
                        <p>Se refiere al tipo de cuenta bancaria que puede tener la institución financiera en otros bancos locales
                        o internacionales, no se trata de sus propios productos bancarios</p>
                        <p>Se aplica al control de cuentas contables como libro bancos</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoProv">
                        <g:link controller="tipoProveedor" action="list" class="tamano">Tipo de Proveedor</g:link> como contribuyentes
                        normales, especiales y el estado.
                    </span>
                    <div class="descripcion hide">
                        <h4>Tipo de Proveedor</h4>
                        <p>Sirve para distinguir los varios tipos de proveedores como contribuyentes especiales, particulares y el fisco.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoProc">
                        <g:link controller="tipoProceso" action="list" class="tamano">Tipo de Proceso</g:link> diferentes tipos de procesos contables
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Proceso</h4>
                        <p>Diferentes tipos de procesos contables</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="paramsAux">
                        <g:link controller="parametrosAuxiliares" action="list" class="tamano">IVA</g:link> para definir
                        valores del IVA.
                    </span>

                    <div class="descripcion hide">
                        <h4>Parámetros de Funcionamiento</h4>
                        <p>Parámetros de funcionamiento generales como el valor del IVA.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="anio">
                        <g:link controller="anio" action="list" class="tamano">Año</g:link> administración de los años y sus respectivos sueldos básicos
                    </span>

                    <div class="descripcion hide">
                        <h4>Año</h4>

                        <p>Administración de los años y sus respectivos sueldos básicos</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="bodega">
                        <g:link controller="bodega" action="list" class="tamano">Bodega</g:link> administración de bodegas
                    </span>

                    <div class="descripcion hide">
                        <h4>Bodega</h4>

                        <p>Administración de Bodegas</p>
                    </div>
                </li>
            </ul>
        </div>
        <div class="generales right pull-right">
        </div>
    </div>

    <div class="tab-pane" id="empresa">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa fa-building"></i>
                    <span id="paramsEmp">
                        <g:link controller="empresa" action="list" params="[tipo: 1]" class="tamano">Parámetros de la Empresa</g:link> para definir la forma de
                        funcionamiento de la contabilidad, centros de costos y control de inventarios.
                    </span>

                    <div class="descripcion hide">
                        <h4>Parámetros de la Empresa</h4>
                        <p>Parámetros de funcionamiento de la contabilidad, control de costos y valores del IVA, en la Empresa,</p>
                    </div>
                </li>
                <li>
                    <i class="fa fa-building"></i>
                    <span id="tipoEmpresa">
                        <g:link controller="tipoEmpresa" action="list" class="tamano">Tipo de Empresa</g:link>, clasificación para registro
                        y control de empresas que reciben el servicio
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Empresa</h4>
                        <p>Sirve para distinguir de entre los distinctos tipos de empresas beneficiarios del servicio.</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="empresa right pull-right">
        </div>
    </div>

    <div class="tab-pane" id="sri">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoId">
                        <g:link controller="tipoIdentificacion" action="list" class="tamano">Tipo de Identificación</g:link> de la persona
                        natural o jurídica, puede ser RUC, Cédula, pasaporte, etc.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Identificaci&oacute;n</h4>
                        <p>Tipos de identificación que posee la persona natural o jurídica, como por ejempla RUC, cédula, pasaporte, etc.</p>
                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoTra">
                        <g:link controller="tipoTransaccion" action="list" class="tamano">Tipo de Transacción</g:link> Compra, venta, etc.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Transacción</h4>
                        <p>Tipos de Transacción del proceso.</p>
                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>
            </ul>
        </div>
        <div class="sri right pull-right">
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnCR").click(function () {
        location.href='${createLink(controller: 'conceptoRetencionImpuestoRenta', action: 'list')}?max=' + 10 + "&offset=" + 0
    });

    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });
    });
</script>

</body>
</html>