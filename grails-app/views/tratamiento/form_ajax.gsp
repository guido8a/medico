<%@ page import="geografia.Provincia" %>

<g:form class="form-horizontal" name="frmTratamiento" role="form" controller="tratamiento" action="saveTratamiento_ajax" method="POST">
    <g:hiddenField name="id" value="${tratamiento?.id}" />
    <g:hiddenField name="historial" value="${historial?.id}" />

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'cantidad', 'error')} required">
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <span class="col-md-2">
                <g:textField name="orden"  class="form-control text-info"  value="${tratamiento?.orden ?: (maximo + 1)}"/>
            </span>
            <label class="col-md-6 control-label text-info" style="text-align: left; margin-left: -20px">
                (número de línea a imprimirse en la receta)
            </label>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'medicina', 'error')} ">
        <span class="grupo">
            <label for="medicinaNombre" class="col-md-2 control-label text-info">
                Nombre Genérico
            </label>
            <span class="col-md-8">
                <g:hiddenField name="medicina" value="${tratamiento?.medicina?.id}"/>
                <g:textArea name="medicinaNombre" class="form-control " readonly="" style="resize: none; height: 60px;"  value="${tratamiento?.medicina ? tratamiento?.medicina?.descripcion : ''}"/>
            </span>
            <span class="col-md-2">
                <a href="#" id="btnBuscarMedicina" class="btn btn-sm btn-info" style="" title="Buscar medicina">
                    <i class="fa fa-search"></i> Buscar
                </a>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'medicina', 'error')} ">
        <span class="grupo">
            <label for="medicinaNombreComercial" class="col-md-2 control-label text-info">
                Nombre Comercial
            </label>
            <span class="col-md-8">
                <g:textField name="medicinaNombreComercial" class="form-control " readonly=""
                             value="${tratamiento?.medicina ? tratamiento?.medicina?.descripcion : ''}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'medicina', 'error')} required">
        <span class="grupo">
            <label for="cantidad" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-4">
                <g:textField name="medicinaCodigo" readonly="" class="form-control"  value="${tratamiento?.medicina?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'medicina', 'error')} required">
        <span class="grupo">
            <label for="cantidad" class="col-md-2 control-label text-info">
                Concentración
            </label>
            <span class="col-md-4">
                <g:textField name="medicinaConcentracion" readonly="" class="form-control"  value="${tratamiento?.medicina?.concentracion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'cantidad', 'error')} required">
        <span class="grupo">
            <label for="cantidad" class="col-md-2 control-label text-info">
                Cantidad
            </label>
            <span class="col-md-4">
                <g:textField name="cantidad"  class="form-control"  value="${tratamiento?.cantidad}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tratamiento, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Prescripción
            </label>
            <span class="col-md-10">
                <g:textArea name="descripcion" style="resize: none; height: 200px" maxlength="255" class="form-control required" value="${tratamiento?.descripcion}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    var dm;

    $("#btnBuscarMedicina").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'buscarMedicina_ajax')}",
            data    : {},
            success : function (msg) {
                dm = bootbox.dialog({
                    id      : "dlgBuscarMedicina",
                    title   : "Buscar",
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
            } //success
        }); //ajax
    });

    function cerrarMedicina(){
        dm.modal("hide");
    }


    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#cantidad").keydown(function (ev) {
        return validarNum(ev);
    });


    $("#frmTratamiento").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitFormTratamiento();
            return false;
        }
        return true;
    });
</script>
