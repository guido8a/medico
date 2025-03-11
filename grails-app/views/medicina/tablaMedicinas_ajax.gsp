<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 7%">Código</th>
            <th style="width: 15%">Nombre Genérico</th>
            <th style="width: 15%">Nombre</th>
            <th style="width: 12%">Cuadro Básico</th>
            <th style="width: 10%">Forma</th>
            <th style="width: 8%">Concentración</th>
            <th style="width: 8%">Medicina</th>
            <th style="width: 8%">Laboratorio</th>
            <th style="width: 5%">Cantidad</th>
            <th style="width: 5%">Estado</th>
            <th style="width: 7%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <g:each in="${datos}" status="i" var="medicina">
                <tr data-id="${medicina.mdcn__id}">
                    <td style="width: 7%">${medicina.mdcncdgo}</td>
                    <td style="width: 15%">${medicina.mdcntpmd == 'G' ? medicina.mdcndscr : medicina.pdredscr}</td>
                    <td style="width: 15%">${medicina.mdcndscr}</td>
                    <td style="width: 12%">${medicina.mdcnpdre ? (medicina.pdrecdgo?:'S/C' + " - " + medicina.pdredscr) : ''}</td>
                    <td style="width: 10%">${medicina.mdcnfrma}</td>
                    <td style="width: 8%">${medicina.mdcncnct}</td>
                    <td style="width: 8%">${medicina.mdcntpmd == 'G' ? 'GENÉRICO' : 'COMERCIAL'}</td>
                    <td style="width: 8%">${medico.Laboratorio.get(medicina?.labt__id)?.nombre}</td>
                    <td style="width: 5%">${medicina.mdcncntd}</td>
                    <td style="width: 5%; background-color:  ${medicina.mdcnetdo == 'A' ? '#b5e898' : '#E22B0C'}">${medicina.mdcnetdo == 'A' ? 'Activo' : 'Inactivo'}</td>
                    <td style="width: 7%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnEditarMedicina" data-id="${medicina.mdcn__id}" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-danger btnEliminarMedicina" data-id="${medicina.mdcn__id}" title="Eliminar">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    // $("tr").contextMenu({
    //     items  : createContextMenu,
    //     onShow : function ($element) {
    //         $element.addClass("trHighlight");
    //     },
    //     onHide : function ($element) {
    //         $(".trHighlight").removeClass("trHighlight");
    //     }
    // });

    $(".btnEditarMedicina").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarMedicina").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });


</script>