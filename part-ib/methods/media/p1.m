f = @(theta) theta .* (1-theta);
x = -5:0.02:5;
y = f(x - floor(x));

plot(x, y, LineWidth=1, Color="#007af5");
xlim([-5 5]);
ylim([-0.2 0.5]);
grid();

xlabel("$\theta$", Interpreter="latex");
ylabel("$f(\theta)$", Interpreter="latex");
fontname("IBM Plex Sans");

theme("light");
set(gca, OuterPosition=[0,0,1,1]);
set(gca, Position=[0.1,0.2,0.85,0.7]);

set(gca, Color="none");
set(gcf, Color="none");
set(gcf, Position=[10,10,600,250]);


saveas(gcf, "p1", "svg")

