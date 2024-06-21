<div class="form-group">
    <span class="grupo">
        <label class="col-md-2 control-label text-info">
            Examen
        </label>
        <span class="col-md-10">
            <g:select name="examen" from="${examenes}" optionKey="id" class="form-control" value="${examenComplementario?.examen?.id}"
                      optionValue="descripcion"/>
            <p class="help-block ui-helper-hidden"></p>
        </span>
    </span>
</div>