// Dimensions of sunburst.
var width = 900,
    height = width,
    radius = width / 2,
    x = d3.scale.linear().range([0, 2 * Math.PI]),
    y = d3.scale.pow().exponent(1.3).domain([0, 1]).range([0, radius]),
    padding = 20,
    duration = 1000;

var formatNumber = d3.format(",d");

var svg = d3.select("#sunburst").append("svg")
    .attr("width", width + padding * 2)
    .attr("height", height + padding * 2)
    .append("g")
    .attr("transform", "translate(" + [radius + padding, radius + padding] + ")");

var partition = d3.layout.partition()
    .sort(null)
    .value(function(d) { return 5.8 - d.depth; });

var arc = d3.svg.arc()
    .startAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x))); })
    .endAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx))); })
    .innerRadius(function(d) { return Math.max(0, d.y ? y(d.y) : d.y); })
    .outerRadius(function(d) { return Math.max(0, y(d.y + d.dy)); });

var tooltip = d3.select("body")
    .append("div")
    .attr("class", "tooltip")
    .style("position", "absolute")
    .style("z-index", "10")
    .style("opacity", 1);

function tooltipDes(d) {
    if (d.description != null) {
        var des = d.description;
        tooltip.classed("active", true);
        return  '<p>' + des + '</p>';
    }else{
        tooltip.classed("active", false);
    }
 }

var nodes, path, d, text, textEnter, root;

d3.json("../lib/json/taste.json", function(error, root) {
    if (error) throw error;
    nodes = root;
    path = svg.datum(root).selectAll("path")
        .data(partition.nodes)
        .enter().append("path")
        .attr("display", function(d) { return d.depth ? null : "none";}) // hide inner ring
        .attr("id", function(d, i) { return "path-" + i; })
        .attr("d", arc)
        .attr("fill-rule", "evenodd")
        .style("fill", colour)
        //.on("click", click)
        .on("mouseover", function(){return tooltip.style("visibility", "visible");})
        .on("mousemove", mousemove)
        .on("mouseout", function(){return tooltip.style("visibility", "hidden");});

        // Select all the visible labels
        text = svg.datum(root).selectAll("text").data(partition.nodes);
        textEnter = text.enter().append("text")
            .style("fill-opacity", 1)
            .style("fill","#fff")
            .attr("text-anchor", function(d) {
              return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
            })
            .attr("dy", ".2em")

            // rotate the lable text dependign where it is
            .attr("transform", function(d) {
              var multiline = (d.name || "").split(" ").length > 1,
                  angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                  rotate = angle + (multiline ? -.5 : 0);
              return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
            })

            // Add the mouse clic handler to the bounding circle.
            //.on("click", click)
            .on("mouseover", function(){return tooltip.style("visibility", "visible");})
            .on("mousemove", mousemove)
            .on("mouseout", function(){return tooltip.style("visibility", "hidden");});
        textEnter.append("tspan")
            .attr("x", 0)
            .text(function(d) { return d.depth ? d.name.split(" ")[0] : ""; });
        textEnter.append("tspan")
            .attr("x", 0)
            .attr("dy", "1em")
            .text(function(d) { return d.depth ? d.name.split(" ")[1] || "" : ""; });
  });
    function mousemove(d) {
        // Fade all the segments.
        d3.selectAll("path").style("opacity", 1);
        tooltip.html(function() {
              var des = tooltipDes(d);
              return des;
              if (des != "undefined") {
                console.log('someting');
                return tooltip.style("visibility", "visible");
              }else{
                  console.log('nothing');
                return tooltip.style("visibility", "hidden");
              }
         });
         return tooltip.transition()
            .duration(50)
            .style("opacity", 1)
            .style("top", (d3.event.pageY - 60)+"px")
            .style("left", (d3.event.pageX - 10)+"px");
    }
    // Then highlight only those that are an ancestor of the current segment.
    var sequenceArray = getAncestors(d);

    // Given a node in a partition layout, return an array of all of its ancestor
    // nodes, highest first, but excluding the root.
    function getAncestors(node) {
       var path = [];
       var current = node;
       //while (current.parent) {
       while (root) {
           path.unshift(current);
           current = current.parent;
       }
       return path;
    }
    svg.selectAll("path")
      .filter(function(node) {
         return (sequenceArray.indexOf(node) >= 0);
              })
      .style("opacity", 1);

    function click(d) {
      path.transition()
          .duration(duration)
          .attrTween("d", arcTween(d));

      // Somewhat of a hack as we rely on arcTween updating the scales.
      text.style("visibility", function(e) {
          return isParentOf(d, e) ? null : d3.select(this).style("visibility");
      })
      .transition()
      .duration(duration)
      .attrTween("text-anchor", function(d) {
          return function() {
              return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
          };
      })
      .attrTween("transform", function(d) {
          var multiline = (d.name || "").split(" ").length > 1;
          return function() {
              var angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
              rotate = angle + (multiline ? -.5 : 0);
              return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
          };
      })
      .style("fill-opacity", function(e) { return isParentOf(d, e) ? 1 : 1e-6; })
      .each("end", function(e) {
          d3.select(this).style("visibility", isParentOf(d, e) ? null : "hidden");
      });
  }
    // Interpolate the arcs in data space.
    function arcTween(a) {
      var i = d3.interpolate({x: a.x0, dx: a.dx0}, a);
      return function(t) {
        var b = i(t);
        a.x0 = b.x;
        a.dx0 = b.dx;
        return arc(b);
      };
    }
    function isParentOf(p, c) {
      if (p === c) return true;
      if (p.children) {
        return p.children.some(function(d) {
          return isParentOf(d, c);
        });
      }
      return false;
    }
    function colour(d) {
      if (d.children) {
        // There is a maximum of two children!
        var colours = d.children.map(colour),
            a = d3.hsl(colours[0]),
            b = d3.hsl(colours[1]);
        // L*a*b* might be better here...
        //return d3.rgb((a.h + b.h) / 2, a.s * 1.2, a.l / 1.2);
      }
      return d.colour || "#fff";
    }
    // function description(d) {
    //     if(d.children) {
    //
    //     }
    // }
    // Interpolate the scales!
    function arcTween(d) {
      var my = maxY(d),
          xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
          yd = d3.interpolate(y.domain(), [d.y, my]),
          yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
      return function(d) {
        return function(t) { x.domain(xd(t)); y.domain(yd(t)).range(yr(t)); return arc(d); };
      };
    }
    function maxY(d) {
      return d.children ? Math.max.apply(Math, d.children.map(maxY)) : d.y + d.dy;
    }

    // http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
    function brightness(rgb) {
      return rgb.r * .299 + rgb.g * .587 + rgb.b * .114;
    }
    d3.select("#sunburst").style("height", height + "px");
