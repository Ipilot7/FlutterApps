
Map distance = {
  //m
  'метр':['m',1],
  'километр': ['km', 0.001],
  'миллиметр': ['mm', 1000],
  'сантиметр': ['cm', 100],
  'миля': ['mi', 0.000621],
  'ярд': ['yd', 1.093613],
  'фут': ['ft', 3.28084],
  'дюйм': ['in', 39.370079],
  'морская миля': ['nmi', 0.00054]
};
Map area = {
  //m2
  "квадратный метр": ["m²", 1],
  'квадратный миллиметр': ['mm²', 100000],
  'квадратный сантиметр': ['cm²', 10000],
  'квадратный дюйм': ['in²', 1550.0031],
  'квадратный фут': ['ft²', 10.76391],
  'квадратный ярд': ['yd²', 1.19599],
  'гектар': ['ha²', 0.0001],
  'квадратный километр': ['km²', 0.000001],
  'арк': ['ac', 0.000247],
  'квадратный миля': ['mi²', 0.000000386]
};
Map mass = {
  //kg
  "килограмм": ["kg", 1],
  'милли грамм': ['mg', 1000000],
  'грам': ['g', 1000],
  'тонна': ['t', 0.001],
  'длинная тонна': ['ton(UK)', 0.0000984],
  'короткая тонна': ['ton(US)', 0.0011],
  'фунт': ['lb', 2.204622],
  'унция': ['ounce', 35.273991],
  'камень': ['st', 0.157],
  'карат': ['ct', 5000]
};
Map volume = {
  //m3
  " кубический м": ["m³", 1],
  'кубический  мм': ['mm³', 1000000000],
  'кубический см': ['cm³', 1000000],
  'кубический дм ': ['dm³', 1000],
  'мл': ['ml(cc)', 1000000],
  'л': ['L', 1000],
  'кубический фут': ['ft³', 35.314725],
  'кубический дюйм': ['in³', 61023.844502],
  '(США)галон': ['gal(US)', 264.172052],
  '(США)кварта': ['qt lqd(US)', 1056.688209],
  '(США)пинта': ['pt lqd(US)', 2113.376419],
  '(США)унцип': ['oz(US)', 33814.022702],
  '(США)чашка': ['cup(US)', 4226.752838],
  '(США)столовая ложка': ['tbsp(US)', 67628.04504],
  '(США)чайная ложка': ['tsp(US)', 202884.136211],
  '(Великобритания)галлон': ['gal(UK)', 219.9691157],
  '(Великобритания)кварта': ['qt(UK)', 879.894413],
  '(Великобритания)пинта': ['pt(UK)', 1759.633996],
  '(Великобритания)унция': ['oz(UK)', 35195.079728],
  '(Великобритания)чашка': ['cup(UK)', 3519.503328],
  '(Великобритания)ст л.': ['tbsp(UK)', 56312.647821],
  '(Великобритания)ч л.': ['tsp(UK)', 168947.457341],
  'драм': ['dr', 270512.181615],
  'барель': ['bbl', 6.289811],
  'корд': ['cord', 0.276],
  'гипп': ['gill', 8453.799983]
};
Map temperature = {
  //Celsiy
  "Целсия": ["C", -272],
  'Кельвин': ['K', 274], 'Фаренгейт': ['F', 33.8]
};
Map fuel = {

  //km/L
   "км/л": ["km / L", 100],
  'л/100 км': ['L/100km', 0.01],
  'гаплонов(Великобритания)/100': ['gal(UK)/100 miles', 0.00354],
  'гаплонов(США)/100 миль': ['gal(US)/100 miles', 0.00425],
  '(Великобритания)миль/гаплон': ['MPG(UK)', 2.82480936],
  '(США)миль/гаплон': ['MPG(US)', 2.35214583],
};
Map coocking = {
  //mL/cc миллилитр
  
  "миллилитр": ["mL (cc)", 1],
  'галлон(США)': ['gal(US)', 0.000264],
  'кварта(США)': ['qt lqd(US)', 0.00106],
  'пинта(США)': ['pt lqd(US)', 0.00211],
  'унция(США)': ['fl oz(US)', 0.0338],
  'кружка(США)': ['cup(US)', 0.00423],
  'столовая ложка(США)': ['tbsp(US)', 0.0676],
  'чайная ложка(США)': ['tsp(US)', 0.203],
  'галлон': ['gal(UK)', 0.00022],
  'кварта': ['qt(UK)', 0.00088],
  'пинта': ['pt(UK)', 0.00176],
  'унция': ['fl oz(UK)', 0.0352],
  'кружка': ['cup(UK)', 0.00352],
  'столовая ложка': ['tbsp(UK)', 0.0563],
};
List<Map> mapNames = [distance, area, mass, volume,temperature,fuel,coocking];
//----------------------------------------------------------------------------
Map tabsEliments={
  'метр':'m',
  'квадратный метр':'m²',
  'килограмм':'кг',
  'кубический м':'m³',
  'Целсия':'C',
  'км/л':'km / L',
  'миллилитр':'mL (cc)',

};
