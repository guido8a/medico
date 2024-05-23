<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">RUC</th>
            <th style="width: 30%">Nombre</th>
            <th style="width: 30%">Tipo de Consultorio</th>
            <th style="width: 15%">Provincia</th>
            <th style="width: 15%">Acciones</th>
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
                <td style="width: 30%">${empresa.emprnmbr}</td>
                <td style="width: 30%">${seguridad.TipoEmpresa.get(empresa.tpem__id)}</td>
                <td style="width: 15%">${geografia.Canton.get(empresa.cntn__id)?.provincia?.nombre}</td>
                <td style="width: 15%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnEditar" data-id="${empresa.empr__id}" title="Editar">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-warning btnLogo" data-id="${empresa.empr__id}" title="Logo">
                        <i class="fa fa-file"></i>
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

    $(".btnLogo").click(function () {
        var id = $(this).data("id");
        cargarLogo(id);
    });

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

    function cargarLogo(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'logoEmpresa_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                di = bootbox.dialog({
                    id      : "dlgFoto",
                    title   : "Logo",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit
</script>