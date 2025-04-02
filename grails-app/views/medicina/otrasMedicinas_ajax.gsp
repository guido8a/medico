<div class="row">
    <div class="col-md-12">
        <g:select name="nueva" id="nueva" from="${todas}"
                  optionKey="${{it.id}}"
                  optionValue="${{it?.codigo ? (it?.codigo + " - " + (it.descripcion ? it.descripcion : 'S/N - Sin nombre') + " - Forma: " + it?.forma + " - Concen:" + it?.concentracion) : (it.descripcion ? it.descripcion : 'S/N - Sin nombre')+ " - Forma: " + it?.forma + "- Concen:" + it?.concentracion}}"
                  class="form-control" />
    </div>
</div>