<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">RUC</th>
            <th style="width: 35%">Nombre</th>
            <th style="width: 30%">Tipo de Consultorio</th>
            <th style="width: 15%">Provincia</th>
            <th style="width: 10%">Acciones</th>
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
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnEditar" data-id="${empresa.empr__id}" title="Editar">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-info btnPacientes" data-id="${empresa.empr__id}" title="Pacientes">
                        <i class="fas fa-users"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-danger btnEliminar" data-id="${empresa.empr__id}" title="Eliminar">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminar").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    $(".btnPacientes").click(function () {
        var id = $(this).data("id");
        location.href="${createLink(controller: 'paciente', action: 'list')}/" + id;
    });

    // $("tr").contextMenu({
    //     items  : createContextMenu,
    //     onShow : function ($element) {
    //         $element.addClass("trHighlight");
    //     },
    //     onHide : function ($element) {
    //         $(".trHighlight").removeClass("trHighlight");
    //     }
    // });

</script>