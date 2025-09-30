<div class="row" style="text-align: center; font-size: 16px">
    <div class="col-md-12">
        <div class="col-md-2"></div>
        <div class="col-md-4 alert alert-success negrilla text-success">
            Valor total a pagar: <g:formatNumber number="${proceso?.valor ?: 0}" maxFractionDigits="2" minFractionDigits="2"/>
        </div>
        <div class="col-md-4 alert alert-info negrilla text-warning">
            Saldo por pagar: <g:formatNumber number="${restante}" maxFractionDigits="2" minFractionDigits="2"/>
        </div>
    </div>
</div>