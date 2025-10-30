<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Transacciones anuladas</title>
    <style type="text/css">

    </style>
</head>
<body>
<div class="row">
    <div class="col-md-12" style="margin-bottom: 10px">
        <div class="col-md-2">
            <a href="#" class="btn btn-info" id="btnRegresar">
                <i class="fa fa-arrow-left"></i>
                Procesos
            </a>
        </div>
        <div class="col-md-1">
            <label>Contabilidad:</label>
        </div>
        <div class="col-md-7">
            <g:select name="contabilidad"  class="form-control label-shared" id="contabilidad"
                      from="${sri.Contabilidad.findAllByInstitucion(session.empresa,[sort:'id',order:'desc'])}" value="${contabilidad.id}" optionKey="id"/>
        </div>
    </div>
    <table class="table table-bordered table-hover table-striped table-condensed">
        <thead>
        <tr style="width: 100%">
            <th style="width: 55%">Descripción</th>
            <th style="width: 15%">Fecha</th>
            <th style="width: 15%">Comprobate</th>
            <th style="width: 25%">Valor</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${procesos}">
            <g:each in="${procesos}" var="p">
                <tr style="width: 100%">
                    <td style="width: 55%">${p.descripcion}</td>
                    <td style="width: 15%">${p.fecha.format("dd/MM/yyyy")}</td>
                    <g:set var="comp" value="${sri.Comprobante.findByProceso(p)}"/>
                    <g:if test="${comp}">
                        <td style="width: 15%"><g:link controller="proceso" action="verComprobante" id="${comp.id}">${comp?.numero}</g:link></td>
                    </g:if>
                    <g:else>
                        <td style="width: 15%"></td>
                    </g:else>
                    <td style="text-align: right; width: 25%">${(p.valor+p.impuesto).round(2)}</td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr class="danger text-center">
                <td colspan="6">No se encontraron procesos anulados</td>
            </tr>
        </g:else>
        </tbody>
    </table>
</div>
<script type="text/javascript">

    $("#btnRegresar").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'buscarPrcs')}/" + '${paciente?.id}'
    });

    $("#contabilidad").change(function(){
        location.href="${g.createLink(controller: 'proceso',action: 'procesosAnulados')}?contabilidad="+$(this).val() + "&paciente=" + '${paciente?.id}'
    })

</script>
</body>
</html>