<div class="row">
    <div class="col-md-11 breadcrumb">
        <div class="col-md-2 tamano bd">
            Establecimiento:
        </div>

        <div class="col-md-9 tamano ">
            <g:select name="establecimientos" from="${sri.Establecimiento.findAllByEmpresa(empresa)}" optionValue="${{it.nombre  + " - " + it.direccion}}" optionKey="id" class="form-control"/>
        </div>

        <div class="btn-group col-md-1">
            <a href="#" class="btn btn-sm btn-success btnEditarEstablecimiento" data-id="${empresa.id}" title="Editar establecimientos">
                <i class="fas fa-edit"></i> Editar
            </a>
        </div>

        <div class="col-md-12 tamano" id="divLibretines" style="margin-top: 10px">

        </div>

    </div>
</div>

<script type="text/javascript">

    $("#establecimientos").change(function () {
        cargarLibretines();
    });

    cargarLibretines();

    function cargarLibretines() {
        var establecimiento = $("#establecimientos option:selected").val();
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'libretines_ajax')}',
            data: {
                establecimiento: establecimiento
            },
            success: function (msg) {
                d.modal("hide");
                $("#divLibretines").html(msg)
            }
        })
    }

</script>