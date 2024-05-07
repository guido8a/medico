<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmDocumento" role="form" controller="documento" action="saveDocumento_ajax" method="POST">

        <g:hiddenField name="id" value="${documentoInstance?.id}"/>
        <g:hiddenField name="empresa" value="${documentoInstance?.empresa?.id ?: empresa}"/>

        <div class="form-group keeptogether ${hasErrors(bean: documentoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label">
                    Descripción
                </label>

                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="63" class="form-control input-sm required"
                                 value="${documentoInstance?.descripcion}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: documentoInstance, field: 'clave', 'error')} ">
            <span class="grupo">
                <label for="clave" class="col-md-3 control-label">
                    Palabras Clave
                </label>

                <div class="col-md-8">
                    <g:textField name="clave" maxlength="63" class="form-control input-sm" value="${documentoInstance?.clave}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: documentoInstance, field: 'resumen', 'error')} ">
            <span class="grupo">
                <label for="resumen" class="col-md-3 control-label">
                    Resumen
                </label>

                <div class="col-md-8">
                    <g:textArea name="resumen" cols="40" rows="5" maxlength="1024" class="form-control input-sm"
                                value="${documentoInstance?.resumen}" style="resize: none"/>
                </div>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitFormDocumento();
            return false;
        }
        return true;
    });
</script>

