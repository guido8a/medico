<g:form class="form-horizontal" name="frmGrupo" controller="producto" action="saveGrupo_ajax">
    <g:hiddenField name="id" value="${grupo?.id}"/>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="grupo">
                <span class="col-md-8">
                    <g:textField name="descripcion" minlength="3" maxlength="63" required="" class="form-control required" value="${grupo?.descripcion}"/>
                </span>
            </span>
        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <span class="grupo">
                <span class="col-md-3">
                    <g:textField name="orden" minlength="1" maxlength="3" required="" class="form-control required" value="${grupo?.orden}"/>
                </span>
            </span>

        </div>
    </div>
</g:form>

<script type="text/javascript">


</script>