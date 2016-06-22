function dateSave(){
  var night = $('.roundtour-date--night li');
  var nightMin = night.filter('.active').first().text();
  var nightMax = night.filter('.active').last().text();
  var nightResult;
  if(nightMin.indexOf(nightMax)){
    nightResult = 'на ' + nightMin + '-' + nightMax + ' ночей';
  } else{
    nightResult = 'на ' + nightMin + ' ночей';
  }

  var month = $('.select-date').val();
  var arrayMonth, monthResult;
  if(month!=''){
    arrayMonth = month.replace(/\s+/g, '');
    arrayMonth = arrayMonth.split("-");
    if(arrayMonth[0]==arrayMonth[1]){
      monthResult = month.split("-");
      month = monthResult[0];
    }
    month = month + ', '
  }else{
    month = 'Выберите дату';
  }
  $('.roundtour-date--months').text(month);
  $('.roundtour-date--nights').text(nightResult);
}