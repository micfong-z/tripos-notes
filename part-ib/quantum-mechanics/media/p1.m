a = 1;
x = -a:0.002:a;
chi1 = sqrt(1/a) * cos(pi*x/(2*a));
chi2 = sqrt(1/a) * sin(2*pi*x/(2*a));
chi3 = sqrt(1/a) * cos(3*pi*x/(2*a));

hold on;
xline([-a a], ":", Color="#8C8C8C", LineWidth=1);
plot(x, chi1, LineWidth=1, Color="#007af5");
plot(x, chi2, LineWidth=1, Color="#EC6F27");
plot(x, chi3, LineWidth=1, Color="#14AE52");
hold off;

xlim([-1.2 1.2]);
ylim([-1.3 1.3]);
xticks([-a 0 a]);
xticklabels(["$-a$", "$0$", "$a$"]);
yticks([-1 0 1]);
yticklabels(["$-1/\sqrt{a}$", "$0$", "$1/\sqrt{a}$"]);
set(gca, TickLabelInterpreter="latex");
grid();

legend(["", "", "$\chi_1$", "$\chi_2$", "$\chi_3$"], Interpreter="latex", Location="northeastoutside");
xlabel("$x$", Interpreter="latex");
ylabel("$\chi_n(x)$", Interpreter="latex");
fontname("IBM Plex Sans");

theme("light");
set(gca, OuterPosition=[0,0,1,1]);
set(gca, Position=[0.12,0.2,0.72,0.7]);

set(gca, Color="none");
set(gcf, Color="none");
set(gcf, Position=[10,10,600,250]);

saveas(gcf, "p1", "svg")
