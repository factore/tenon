window.numberToWords = n => {
  if (n == 0) return 'zero';
  let a = [
    '', 'one', 'two', 'three', 'four',
    'five', 'six', 'seven', 'eight', 'nine',
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen',
    'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
  ];
  let b = [
    '', '', 'twenty', 'thirty', 'fourty',
    'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
  ];
  let g = [
    '', 'thousand', 'million', 'billion', 'trillion', 'quadrillion',
    'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion'
  ];
  let grp = n => ('000' + n).substr(-3);
  let rem = n => n.substr(0, n.length - 3);
  let fmt = ([h,t,o]) => {
    return [
      Number(h) === 0 ? '' : a[h] + ' hundred ',
      Number(o) === 0 ? b[t] : b[t] && b[t] + '-' || '',
      a[t+o] || a[o]
    ].join('');
  };
  let cons = xs => x => g => x ? [x, g && ' ' + g || '', ' ', xs].join('') : xs;
  let iter = str => i => x => r => {
    if (x === '000' && r.length === 0) return str;
    return iter(cons(str)(fmt(x))(g[i]))
               (i+1)
               (grp(r))
               (rem(r));
  };
  return iter('')(0)(grp(String(n)))(rem(String(n)));
};
