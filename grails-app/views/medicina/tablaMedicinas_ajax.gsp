<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Tipo</th>
            <th style="width: 15%">Código</th>
            <th style="width: 35%">Descripción</th>
            <th style="width: 15%">Concentración</th>
            <th style="width: 15%">Firma</th>
            <th style="width: 10%">Estado</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" status="i" var="medicina">
            <tr data-id="${medicina.mdcn__id}">
                <td style="width: 10%">${medicina.mdcntipo}</td>
                <td style="width: 15%">${medicina.mdcncdgo}</td>
                <td style="width: 35%">${medicina.mdcndscr}</td>
                <td style="width: 15%">${medicina.mdcncnct}</td>
                <td style="width: 15%">${medicina.mdcnfrma}</td>
                <td style="width: 10%">${medicina.mdcnetdo}</td>
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