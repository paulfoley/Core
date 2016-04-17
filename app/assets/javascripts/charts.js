$(document).ready(function() {

    $('#monthly_sales').highcharts({
        title: {
            text: 'Monthly Sales',
            x: -20 //center
        },
        subtitle: {
            text: '2015',
            x: -20
        },
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        yAxis: {
            title: {
                text: '$ (Millions)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valuePrefix: '$'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: 'San Francisco Office',
            data: [7.0,7.1,9.5,7.5,7.7,8.5,10,12,15,20,30,50],
            color: '#ff1a1a'
        }]
    });
    
    $('#market_share').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        colors: ['#4d3571', '#434348', '#90ed7d', '#f7a35c', '#8085e9', 
                '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1'],
        title: {
            text: 'ERP market share Jan-May 2017'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'CORE',
                y: 56.33,
                sliced:true,
                selected:true
            }, {
                name: 'SAP',
                y: 24.03
            }, {
                name: 'Oracle',
                y: 10.38
            }, {
                name: 'Microsoft',
                y: 4.77
            }, {
                name: 'Opera',
                y: 1.11
            }]
        }]
    });
    $('#market').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        colors: ['#4d3571', '#434348', '#90ed7d', '#f7a35c', '#8085e9', 
                '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1'],
        title: {
            text: 'ERP market share Jan-May 2017'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'CORE',
                y: 56.33,
                sliced:true,
                selected:true
            }, {
                name: 'SAP',
                y: 24.03
            }, {
                name: 'Oracle',
                y: 10.38
            }, {
                name: 'Microsoft',
                y: 4.77
            }, {
                name: 'Opera',
                y: 1.11
            }]
        }]
    });
    $('#share').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        colors: ['#4d3571', '#434348', '#90ed7d', '#f7a35c', '#8085e9', 
                '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1'],
        title: {
            text: 'ERP market share Jan-May 2017'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'CORE',
                y: 56.33,
                sliced:true,
                selected:true
            }, {
                name: 'SAP',
                y: 24.03
            }, {
                name: 'Oracle',
                y: 10.38
            }, {
                name: 'Microsoft',
                y: 4.77
            }, {
                name: 'Opera',
                y: 1.11
            }]
        }]
    });
});