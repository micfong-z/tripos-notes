r0 = 5;
xi = 0:0.002:7.5;
eta = xi .* tan(xi);
eta(eta < 0 | eta > 20) = NaN;

theta = linspace(0, pi/2, 400);

g = @(xi) xi .* tan(xi) - sqrt(r0^2 - xi.^2);
xis = [fzero(g, [1e-9, pi/2 - 1e-9]), fzero(g, [pi, min(3*pi/2, r0) - 1e-9])];
etas = sqrt(r0^2 - xis.^2);

hold on;
for n = 1:3
    xline((n-0.5)*pi, ":", Color="#8C8C8C", LineWidth=1);
end
plot(xi, eta, LineWidth=1, Color="#007af5");
plot(r0*cos(theta), r0*sin(theta), LineWidth=1, Color="#EC6F27");
plot(xis, etas, "o", MarkerSize=5, Color="#212121", MarkerFaceColor="#212121");
for n = 1:2
    text(xis(n) + 0.15, etas(n) + 0.4, sprintf("$(\\xi_%d, \\eta_%d)$", n, n), Interpreter="latex", FontSize=12);
end
hold off;

xlim([0 7.5]);
ylim([0 6]);
daspect([1 1 1]);
xticks([0 pi/2 pi 3*pi/2 2*pi]);
xticklabels(["$0$", "$\pi/2$", "$\pi$", "$3\pi/2$", "$2\pi$"]);
yticks([0 r0]);
yticklabels(["$0$", "$r_0$"]);
set(gca, TickLabelInterpreter="latex");
grid();

legend(["", "", "", "$\eta = \xi\tan\xi$", "$\xi^2 + \eta^2 = r_0^2$", ""], Interpreter="latex", Location="northeast");
xlabel("$\xi$", Interpreter="latex");
ylabel("$\eta$", Interpreter="latex");
fontname("IBM Plex Sans");

theme("light");
set(gca, OuterPosition=[0,0,1,1]);
set(gca, Position=[0.1,0.15,0.85,0.8]);

set(gca, Color="none");
set(gcf, Color="none");
set(gcf, Position=[10,10,600,400]);

saveas(gcf, "p2", "svg")
