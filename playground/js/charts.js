var chart1; // globally available

$(document).ready(function() {
    
    $('#metrics').highcharts({
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
            data: [7.0,7.1,9.5,7.5,7.7,8.5,10,12,15,20,30,50]
        }, {
            name: 'New York Office',
            data: [5.0,6.4,5.5,4.2,5.2,10.0,7.4,10.4,20.1,28,42,55]
        }, {
            name: 'London Office',
            data: [3.9, 4.2,4.5, 5.7, 8.5, 11.9, 15.2, 17.0,22,24.2,33.3,45]
        }]
    });

});
Status API Training Shop Blog About Pricing
© 2016 GitHub,
