<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">RUC</th>
            <th style="width: 35%">Nombre</th>
            <th style="width: 30%">Tipo de Consultorio</th>
            <th style="width: 15%">Provincia</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" status="i" var="empresa">
            <tr data-id="${empresa.empr__id}">
                <td style="width: 10%">${empresa.empr_ruc}</td>
                <td style="width: 35%">${empresa.emprnmbr}</td>
                <td style="width: 30%">${seguridad.TipoEmpresa.get(empresa.tpem__id)}</td>
                <td style="width: 15%">${geografia.Canton.get(empresa.cntn__id)?.provincia?.nombre}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $("tr").contextMenu({
        items  : createContextMenu,
        onShow : function ($element) {
            $element.addClass("trHighlight");
        },
        onHide : function ($element) {
            $(".trHighlight").removeClass("trHighlight");
        }
    });

</script>