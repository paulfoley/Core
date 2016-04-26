$(document).ready(function() {
    
        if(!!document.getElementById("main")) {
    
        //HIGHCHARTS
    
        $('#monthly_sales').highcharts({
            chart: {
                type: 'column'
            },
            colors:['#A02020','#20A040'],
            title: {
                text: 'Accounting Overview',
                style: {'fontSize':'2em'}
            },
            xAxis: {
                categories: [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                ],
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Value ($)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>${point.y:.1f}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: 'Invoices',
                data: gon.invoices
            }, {
                name: 'Payments',
                data: gon.payments
            }]
        });
    }
});