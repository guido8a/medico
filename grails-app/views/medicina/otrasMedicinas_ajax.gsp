<div class="row">
    <div class="col-md-12">

        <div>
            <i class='fa fa-retweet fa-2x pull-left text-danger text-shadow'></i>
            <p style='font-weight: bold; font-size: 14px'> Está seguro que desea reemplazar y dar de baja la medicina? </p>
        </div>

        <g:select name="nueva" id="nueva" from="${todas}"
                  optionKey="${{it.id}}"
                  optionValue="${{it?.codigo ? (it?.codigo + " - " + (it.descripcion ? it.descripcion : 'S/N - Sin nombre') + " - Forma: " + it?.forma + " - Concen:" + it?.concentracion) : (it.descripcion ? it.descripcion : 'S/N - Sin nombre')+ " - Forma: " + it?.forma + " - Concen:" + it?.concentracion}}"
                  class="form-control" />
    </div>
</div>