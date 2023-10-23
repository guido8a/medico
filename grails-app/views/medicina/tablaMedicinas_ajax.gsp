<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Código</th>
            <th style="width: 25%">Descripción</th>
            <th style="width: 20%">Padre</th>
            <th style="width: 25%">Forma</th>
            <th style="width: 10%">Concentración</th>
            <th style="width: 5%">Estado</th>
            <th style="width: 5%">Tipo</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" status="i" var="medicina">
            <tr data-id="${medicina.mdcn__id}">
                <td style="width: 10%">${medicina.mdcncdgo}</td>
                <td style="width: 25%">${medicina.mdcndscr}</td>
                <td style="width: 20%">${medicina.mdcnpdre ? (medico.Medicina.get(medicina.mdcnpdre)?.codigo + " - " +medico.Medicina.get(medicina.mdcnpdre)?.descripcion) : ''}</td>
                <td style="width: 25%">${medicina.mdcnfrma}</td>
                <td style="width: 10%">${medicina.mdcncnct}</td>
                <td style="width: 5%; background-color:  ${medicina.mdcnetdo == 'A' ? '#b5e898' : '#E22B0C'}">${medicina.mdcnetdo == 'A' ? 'Activo' : 'Inactivo'}</td>
                <td style="width: 5%">${medicina.mdcntipo}</td>
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