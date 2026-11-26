Yaa Man Bar & Grill — Sales Analytics (SQL Star Schema + Tableau Dashboard)

Overview

I took a flat sales spreadsheet for a restaurant's first six months of trading, remodelled it into a star schema, wrote the SQL to answer the owner's questions, and built a Tableau dashboard on top. The numbers in the SQL and the dashboard match, so the data can be checked end to end.

Business Questions

How many orders did we have, and how much revenue did they bring in?
Which categories sold the most?
Which table numbers were the most popular?
Who were our top-performing servers?
How did sales trend month to month after launch?
Which payment methods do customers use most?
Where can we improve?
Headline Numbers
Metric	Result
Total orders	636
Total revenue	5,968
Average order value	9.384

Average order value is revenue divided by distinct orders, not by line count, because one order can have several lines.

Key Findings

A note on labels: the dashboard chart titles say "Total Sales", but the bars are counts of distinct orders, not money. I've called them orders here.

Orders by category
Category	Orders
Main	195
Drink	159
Starter	125
Side	101
Dessert	56

Mains lead, then drinks. Desserts sell less than a third as much as mains.

Orders by table (top 6)
Table	Orders
1	163
2, 3, 5, 11, 13	low 30s each

Table 1 accounts for roughly a quarter of all orders (163 of 636). The next five are close together at around 32-33 each.

Share of orders by server
Server	Share of orders
Damien	24.84%
T. Brown	13.84%
Priya	12.89%
Josh	12.42%
Toni-Ann	12.11%
Kayla	11.01%

Damien handles nearly double the share of anyone else.

Orders by month
Month	Orders
January	103
February	97
March	95
April	102
May	111
June	108

Orders dipped to a low in March, then recovered to peak in May.

Orders by payment method
Method	Orders	Share
Card	272	43%
Cash	183	29%
Online	95	15%
Contactless	86	14%

Recommendations

Here's what I'd take to the owner based on the numbers.

Payments. Card is the most used method and cash is second, so I'd keep both going. A few more card machines would make sense if customers are waiting to pay, but the data can't tell me that. I'd want to see how long people queue at busy times before spending money on hardware. Contactless is the smallest at 86 orders, so getting more people to tap would speed things up without buying anything. I'd still keep a decent float in the till because cash is close to a third of orders.

Table 1. It had 163 orders, around five times the next busiest table. That gap is big enough that I'd first check whether table 1 is a real table or just where takeaway or bar orders get rung through. If it's a real table, it's worth looking at why it works (near the door? near the bar? easy for staff to reach?) and trying to copy that for the quieter tables. If it's a catch-all, then the real finding is that a lot of orders aren't seated dine-in. Either way I'd also compare revenue per table, because busy doesn't always mean high spend.

Desserts. Only 56 orders, well behind everything else. Servers asking at the end of the meal or a simple main and dessert deal would be the easiest thing to test.

Order value. Average order is 9.38. Mains are the biggest category, so suggesting a drink or a side with them is the obvious way to push that up.

Staff. Damien has nearly double the share of orders of anyone else. I'd find out what he does differently (upselling, shifts, how he handles his tables) and see if the rest of the team can pick it up.

The early dip. Orders fell in February and March before recovering to a peak in May. I can't tell why from this data, but it would be worth checking promotions and staffing for those months so it doesn't happen again.
