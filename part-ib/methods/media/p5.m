x = 0:0.002:3*pi;
t = tan(x);
t(abs(t) > 20) = NaN;

g = @(mu) sin(mu) + mu .* cos(mu);
mus = zeros(1, 3);
for n = 1:3
    mus(n) = fzero(g, [(n-0.5)*pi + 1e-9, n*pi]);
end
fontname("IBM Plex Sans");

hold on;
for n = 1:3
    xline((n-0.5)*pi, ":", Color="#8C8C8C", LineWidth=1);
end
plot(x, t, LineWidth=1, Color="#007af5");
plot(x, -x, LineWidth=1, Color="#EC6F27");
plot(mus, -mus, "o", MarkerSize=5, Color="#212121", MarkerFaceColor="#212121");
for n = 1:3
    text(mus(n) + 0.15, -mus(n) - 0.9, sprintf("$\\mu_%d$", n), Interpreter="latex", FontSize=12);
end
hold off;

xlim([0 3*pi]);
ylim([-10 4]);
xticks(0:pi/2:3*pi);
xticklabels(["0", "π/2", "π", "3π/2", "2π", "5π/2", "3π"]);
grid();

legend(["", "", "", "$y = \tan\mu$", "$y = -\mu$", ""], Interpreter="latex", Location="northeast");
xlabel("$\mu$", Interpreter="latex");
ylabel("$y$", Interpreter="latex");
fontname("IBM Plex Sans");

theme("light");
set(gca, OuterPosition=[0,0,1,1]);
set(gca, Position=[0.1,0.2,0.85,0.7]);

set(gca, Color="none");
set(gcf, Color="none");
set(gcf, Position=[10,10,600,250]);

saveas(gcf, "p5", "svg")
