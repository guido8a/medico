<div class="" style="width: 99.7%;overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 30%; font-weight: bolder" class="alert alert-info">Antecedentes patológicos personales:</td>
            <td style="width: 70%; background-color: #c1cfe7">${paciente?.antecedentes}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-info">Antecedentes patológicos ocupacionales:</td>
            <td style="width: 70%; background-color: #c1cfe7">${paciente?.antecedentesOcupacionales}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-info">Antecedentes patológicos familiares:</td>
            <td style="width: 70%; background-color: #c1cfe7">${paciente?.antecedentesPatologicosFam}</td>
        </tr>
        <g:if test="${paciente?.sexo == 'F'}">
            <tr style="font-size: 16px">
                <td style="width: 30%;font-weight: bolder" class="alert alert-info">Antecedentes patológicos gineco obstétricos:</td>
                <td style="width: 70%; background-color: #c1cfe7">${paciente?.antecedentesGinecobstreticos}</td>
            </tr>
        </g:if>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-info">Hábitos:</td>
            <td style="width: 70%; background-color: #c1cfe7">${paciente?.habitos}</td>
        </tr>
        </tbody>
    </table>
</div>