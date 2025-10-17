<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Comprobante del Proceso </title>
</head>

<body>

<div class="btn-group" style="margin-right: 20px">
    <a href="#" class="btn btn-primary" id="listaProceso">
        <i class="fa fa-arrow-left"></i>
        Lista de Procesos
    </a>
    <a href="#" class="btn btn-info" id="irProceso">
        <i class="fa fa-arrow-left"></i>
        Proceso
    </a>
%{--    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' && proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim() == '41'}">--}%
%{--        <a href="#" class="btn btn-success" id="reembolsoN">--}%
%{--            <i class="fa fa-thumbs-up"></i>--}%
%{--            Reembolso--}%
%{--        </a>--}%
%{--    </g:if>--}%
</div>

<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:700px; max-height: 720px; overflow: auto;">
        <p class="css-vertical-text">Comprobante</p>

        <div class="linea"></div>

        <div id="divComprobanteP" class="col-xs-12"style="height: 500px">
        </div>
    </div>
</g:if>

<script type="text/javascript">

    cargarComprobanteP('${proceso?.id}');

    function cargarComprobanteP(proceso) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso',action: 'comprobante_ajax')}",
            data: {
                proceso: proceso
            },
            success: function (msg) {
                $("#divComprobanteP").html(msg);
            }
        });
    }

    $("#irProceso").click(function () {
        location.href='${createLink(controller: 'proceso', action: 'procesoForm')}/' + '${proceso?.id}'
    });

    $("#listaProceso").click(function () {
        location.href='${createLink(controller: 'proceso', action: 'buscarPrcs')}/' + '${proceso?.paciente?.id}'
    });

    $("#reembolsoN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'reembolso')}/?proceso=" + '${proceso?.id}'
    });

</script>

</body>
</html>