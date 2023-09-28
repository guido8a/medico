<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">RUC</th>
            <th style="width: 35%">Nombre</th>
            <th style="width: 30%">Tipo de Empresa</th>
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
            <tr>
                <td style="width: 10%">${empresa.empr_ruc}</td>
                <td style="width: 35%">${empresa.emprnmbr}</td>
                <td style="width: 30%">${seguridad.TipoEmpresa.get(empresa.tpem__id)}</td>
                <td style="width: 15%">${geografia.Canton.get(empresa.cntn__id)?.provincia?.nombre}</td>
                <td style="width: 10%">
                    <a class="btn btn-xs btn-show btn-info" href="#" rel="tooltip" title="Ver" data-id="${empresa.empr__id}">
                        <i class="fa fa-search"></i>
                    </a>
                    <a class="btn btn-xs btn-edit btn-success" href="#" rel="tooltip" title="Editar" data-id="${empresa.empr__id}">
                        <i class="fa fa-edit"></i>
                    </a>

                    <a class="btn btn-xs btn-delete btn-danger" href="#" rel="tooltip" title="Eliminar" data-id="${empresa.empr__id}">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btn-delete").click(function (){
        var id = $(this).data("id");
        deleteRow(id);
    });

    $(".btn-show").click(function (){
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Datos de la Empresa",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    })

</script>