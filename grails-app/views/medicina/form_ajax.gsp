<%@ page import="medico.Medicina" %>

<g:form class="form-horizontal" name="frmMedicina" role="form" controller="medicina" action="saveMedicina_ajax" method="POST">
    <g:hiddenField name="id" value="${medicina?.id}" />
    <g:hiddenField name="padre" value="${medicina?.padre?.id}" />
    <g:hiddenField name="ultimo" value="${medicina?.ultimo}" />

    <div class="form-group ${hasErrors(bean: medicina, field: 'tipoMedicamento', 'error')} required">
        <span class="grupo">
            <label for="tipoMedicamento" class="col-md-2 control-label text-info">
                Tipo de medicamento
            </label>
            <span class="col-md-4">
                <g:select name="tipoMedicamento" class="form-control" from="${['G': 'GENÉRICO', 'C': 'COMERCIAL']}" optionValue="value" optionKey="key" value="${medicina?.tipoMedicamento}"/>
            </span>
            <label for="codigo" class="col-md-2 control-label text-info">
                Tipo
            </label>
            <span class="col-md-2">
                <g:textField name="tipo" maxlength="4" class="form-control " readonly=""  value="${medicina?.tipo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'codigo', 'padre')} ">
        <span class="grupo" id="divMedicamento">
            <label for="padre" class="col-md-2 control-label text-info">
                Medicamento genérico
            </label>
            <span class="col-md-8">
                <g:textField name="nombrePadre" class="form-control allCaps" readonly=""
                             value="${ medicina?.padre ?  ( (medicina?.padre?.codigo?:'S/C') + " - " + medicina.padre?.descripcion) : ''}"/>
            </span>
            <span class="col-md-1">
                <a href="#" class="btn btn-xs btn-info btnBuscarPadre" title="Buscar Padre">
                    <i class="fas fa-search"></i> Buscar
                </a>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'tipoMedicamento', 'error')} required">
        <span class="grupo hidden" id="divLaboratorio">
            <label for="laboratorio" class="col-md-2 control-label text-info">
                Laboratorio
            </label>
            <span class="col-md-6">
                <g:select name="laboratorio" class="form-control" from="${medico.Laboratorio.list([sort: 'nombre'])}" optionValue="nombre" optionKey="id" value="${medicina?.laboratorio?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-10">
                <g:textField name="descripcion" maxlength="255" minlenght="10" required="" class="form-control required" value="${medicina?.descripcion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'codigo', 'error')}">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-6">
                <g:textField name="codigo" readonly="" maxlength="15" class="form-control allCaps" value="${medicina?.codigo}"/>
            </span>
            <label for="estado" class="col-md-1 control-label text-info">
                Estado
            </label>
            <span class="col-md-3">
                <g:select name="estado" class="form-control" from="${['A': 'Activo', 'B': 'Inactivo']}" optionValue="value" optionKey="key" value="${medicina?.estado}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'forma', 'error')} ">
        <span class="grupo">
            <label for="forma" class="col-md-2 control-label text-info">
                Forma
            </label>
            <span class="col-md-6">
                <g:textField name="forma" maxlength="255"  class="form-control required" value="${medicina?.forma}"/>
            </span>
            <label for="cantidad" class="col-md-1 control-label text-info">
                Cantidad
            </label>
            <span class="col-md-3">
                <g:textField name="cantidad" maxlength="5"  class="form-control required" value="${medicina?.cantidad}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'concentracion', 'error')} ">
        <span class="grupo">
            <label for="concentracion" class="col-md-2 control-label text-info">
                Concentración
            </label>
            <span class="col-md-10">
                <g:textField name="concentracion" maxlength="255" class="form-control" value="${medicina?.concentracion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-10">
                <g:textArea name="observaciones" maxlength="255" style="resize: none"  class="form-control" value="${medicina?.observaciones}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    var dp;

    <g:if test="${!medicina?.id}">
    cargarCodigo();
    </g:if>

    function cargarCodigo(){
        var tipo = $("#tipoMedicamento option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'medicina', action: 'buscarCodigo_ajax')}',
            data:{
                tipo: tipo
            },
            success: function (msg){
                var parts = msg.split("_");
                $("#codigo").val(parts[1]);
                $("#ultimo").val(parts[2]);
            }
        })
    }

    cargarLaboratorio($("#tipoMedicamento option:selected").val());

    function cargarLaboratorio(tipo){
        if(tipo === 'C'){
            $("#divLaboratorio").removeClass("hidden");
            $("#divMedicamento").removeClass("hidden");
            $("#tipo").val("COM");
        }else{
            $("#divLaboratorio").addClass("hidden");
            $("#divMedicamento").addClass("hidden");
            $("#tipo").val("CNMB");
        }
    }

    $("#tipoMedicamento").change(function () {
        var tipo = $(this).val();
        cargarLaboratorio(tipo);
        if(tipo === 'C'){
            $("#nombre").addClass("required");
        }else{
            $("#nombre").removeClass("required");
        }

        <g:if test="${!medicina?.id}">
        cargarCodigo();
        </g:if>

    });

    $(".btnBuscarPadre").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'buscarPadre_ajax')}",
            data    : {},
            success : function (msg) {
                dp = bootbox.dialog({
                    id      : "dlgBuscarPadre",
                    title   : "Buscar Medicina Padre",
                    // class: "modal-lg",
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

    function cerrarPadre(){
        dp.modal("hide");
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
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#cantidad").keydown(function (ev) {
        return validarNum(ev);
    });



    $("#frmMedicina").validate({
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
            submitFormMedicina();
            return false;
        }
        return true;
    });
</script>
