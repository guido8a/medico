<g:form class="form-horizontal" name="frmAsiento" role="form" controller="proceso" action="guardarAsiento_ajax" method="POST">
    <g:hiddenField name="cuenta" id="cuenta" value="${asiento?.cuenta?.id}"/>
    <g:hiddenField name="comprobante" id="comprobante" value="${comprobante?.id}"/>
    <g:hiddenField name="asiento" id="asiento" value="${asiento?.id}"/>

    <div class="row">
        <div class="col-md-2">
            <label>Código:</label>
        </div>
        <div class="col-md-4">
            <g:textField name="codigoAsiento_name" id="codigoAsiento" value="${asiento?.cuenta?.numero}" readonly=""  style="width: 150px" class="form-control"/>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-info" id="btnBuscarCuenta"><i class="fa fa-search"></i> Buscar cuenta</a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Nombre:</label>
        </div>
        <div class="col-md-7">
            <g:textField  name="nombreAsiento_name" id="nombreAsiento" value="${asiento?.cuenta?.descripcion}" style="width: 400px" readonly="" class="form-control" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Valor:</label>
        </div>
        <div class="col-md-10">
            <div class="col-md-2">DEBE</div>
            <div class="col-md-3">
                <g:textField type="number" name="debe" id="debe" class="validacionNumero form-control valorD required" style="width: 90px;" value="${asiento?.debe ?: 0}" />
            </div>
            <div class="col-md-2">HABER</div>
            <div class="col-md-3">
                <g:textField type="number" name="haber" id="haber" class="validacionNumero form-control valorH required" style="width: 90px;" value="${asiento?.haber ?: 0}" />
            </div>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    var bcc;

    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39 ||
            ev.keyCode === 110 || ev.keyCode === 190);
    }

    $(".validacionNumero").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

    });

    $("#btnBuscarCuenta").click(function () {
        $.ajax({
            type   : "POST",
            url    : "${createLink(controller: 'proceso', action:'buscarCuenta_ajax')}",
            data   : {
            },
            success: function (msg) {
                bcc = bootbox.dialog({
                    id   : "dlgBuscarCuenta",
                    title: "Buscar cuenta",
                    // class: "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label    : "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarBuscarCuenta() {
        bcc.modal("hide");
    }

</script>
