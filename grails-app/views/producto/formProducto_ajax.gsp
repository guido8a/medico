<g:form class="form-horizontal" name="frmGrupo" controller="producto" action="saveProducto_ajax">
    <g:hiddenField name="id" value="${producto?.id}"/>
    <g:hiddenField name="empresa" value="${empresa?.id}"/>
    <g:hiddenField name="subgrupo" value="${subgrupo?.id}"/>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="grupoName" class="col-md-2 control-label text-info">
                Grupo
            </label>
            <span class="grupo">
                <span class="col-md-8">
                    <g:textField name="grupoName" class="form-control" readonly="" value="${subgrupo?.grupo?.descripcion}"/>
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="subgrupoName" class="col-md-2 control-label text-info">
                Subgrupo
            </label>
            <span class="grupo">
                <span class="col-md-8">
                    <g:textField name="subgrupoName" class="form-control" readonly="" value="${subgrupo?.descripcion}"/>
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="texto" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="grupo">
                <span class="col-md-8">
                    <g:textArea name="texto" minlength="3" maxlength="255" required="" class="form-control required" value="${producto?.texto}"/>
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="precioUnitario" class="col-md-2 control-label text-info">
                Precio unitario
            </label>
            <span class="grupo">
                <span class="col-md-3">
                    <g:textField name="precioUnitario" class="form-control required" value="${producto?.precioUnitario}"/>
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="marca" class="col-md-2 control-label text-info">
                Marca
            </label>
            <span class="grupo">
                <span class="col-md-8">
                   <g:select name="marca" from="${medico.Marca.list().sort{it.descripcion}}" optionValue="descripcion" optionKey="id" class="form-control" value="${producto?.marca?.id}" />
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="tipoIva" class="col-md-2 control-label text-info">
                Tipo de Iva
            </label>
            <span class="grupo">
                <span class="col-md-8">
                    <g:select name="tipoIva" from="${sri.TipoIva.list().sort{it.descripcion}}" optionValue="descripcion" optionKey="id" class="form-control" value="${producto?.tipoIva?.id}" />
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="numero" class="col-md-2 control-label text-info">
                Orden
            </label>
            <span class="grupo">
                <span class="col-md-3">
                    <g:textField name="numero" minlength="1" maxlength="3" class="form-control required" value="${producto?.numero}"/>
                </span>
            </span>
        </div>
    </div>
</g:form>

<script type="text/javascript">

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

    $("#precioUnitario").keydown(function (ev) {
        return validarNum(ev);
    });

</script>