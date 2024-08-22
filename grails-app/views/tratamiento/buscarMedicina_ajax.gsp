<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 5px">
        <div class="row" >
            <div class="col-md-2" style="text-align: right">
                <label class="control-label text-info">Buscar por:</label>
            </div>
            <div class="col-md-3">
                <g:textField name="criterioMedicina" id="criterioMedicina" class="form-control"/>
            </div>
            <div class="col-md-2">
                <button class="btn btn-info" id="btnBuscarListaMedicina"><i class="fa fa-search"></i></button>
                <button class="btn btn-warning" id="btnLimpiarListaMedicina" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
            <div class="col-md-2" style="float: right">
                <button class="btn btn-success" id="btnNuevaMedicina"><i class="fa fa-file"></i> Nueva Medicina</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaMedicina" >
        </div>
    </fieldset>

    <fieldset style="border-radius: 4px; margin-top: 5px">
        <div class="alert alert-warning">
            * Máxima cantidad de registros en pantalla 100
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    var dnm;

    $("#btnNuevaMedicina").click(function () {
        createEditRowMedicina()
    });

    function createEditRowMedicina(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(controller:'medicina' , action: 'form_ajax')}",
            data    : data,
            success : function (msg) {
                dnm = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Medicina",
                    // class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormMedicina();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormMedicina() {
        var $form = $("#frmMedicina");
        if ($form.valid()) {

            var tipo = $("#tipoMedicamento option:selected").val();
            var padre = $("#padre").val();

            if(tipo === 'C' && !padre){
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                    '<strong style="font-size: 14px">' + "Seleccione el medicamente genérico al que pertenece este medicamento comercial" + '</strong>');
                return false
            }else{
                var data = $form.serialize();
                var dialog = cargarLoader("Guardando...");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : data,
                    success : function (msg) {
                        dialog.modal('hide');
                        var parts = msg.split("_");
                        if(parts[0] === 'ok'){
                            log(parts[1], "success");
                            cargarMedicinas();
                            cerrarNuevaMedicina();
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }
                    }
                });
            }
        } else {
            return false;
        }
    }

    function cerrarNuevaMedicina() {
        dnm.modal("hide");
    }

    cargarMedicinas();

    // $("#tipoMedicina").change(function () {
    //     cargarMedicinas();
    // });
    //
    // $("#buscarPorMedicina").change(function () {
    //     cargarMedicinas();
    // });

    $("#btnBuscarListaMedicina").click(function () {
        cargarMedicinas();
    });

    $("#btnLimpiarListaMedicina").click(function () {
        $("#criterioMedicina").val('');
        // $("#buscarPorMedicina").val(1);
        // $("#tipoMedicina").val('G');
        cargarMedicinas();
    });

    function cargarMedicinas(){
        var e = cargarLoader("Cargando...");
        // var buscarPor = $("#buscarPorMedicina option:selected").val();
        var criterio = $("#criterioMedicina").val();
        // var tipoMedicina = $("#tipoMedicina option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tratamiento', action: 'tablaMedicina_ajax')}',
            data:{
                // buscarPor: buscarPor,
                criterio: criterio,
                // tipoMedicina: tipoMedicina
            },
            success: function (msg){
                e.modal("hide");
                $("#divTablaMedicina").html(msg)
            }
        })
    }

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarMedicinas();
            return false;
        }
        return true;
    })

</script>