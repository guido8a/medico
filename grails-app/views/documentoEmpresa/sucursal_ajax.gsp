<div class="col-md-4">
    <g:select class="form-control required cmbRequired" name="numeroEstablecimiento" id="numeroEstablecimiento"
              from="${establecimientos}" label="Proceso tipo: " value="${documentoEmpresaInstance?.numeroEstablecimiento}" optionKey="id"
              optionValue="${{it.numero + " - " + it.nombre}}" title="Sucursales" />
</div>

<div class="col-md-2">
    <a href="#" class="btn btn-sm btn-success btnCrearSucursal" data-id="${empresa?.id}"><i class="fa fa-file"></i> Nueva </a>
</div>

<script type="text/javascript">

    $(".btnCrearSucursal").click(function () {
        var id = $(this).data("id");
        formSucursales(id)
    });

    function formSucursales(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'sucursales_ajax')}",
            data    : {
                id: id,
                tipo: 1
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditSuc",
                    title   : "Sucursales de la empresa",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit


</script>