#Research Question
#Does mean age differ significantly across the five levels of AI familiarity?

#Research Hypotheses
#Null Hypothesis (H₀):
#There is no statistically significant difference in mean age across the five AI familiarity groups.
#[H_0: \mu_1 = \mu_2 = \mu_3 = \mu_4 = \mu_5]

#Alternative Hypothesis (H₁):
#At least one AI familiarity group has a different mean age from another group.
#[H_1: \text{Not all five group means are equal}]

import pandas as pd

df = pd.read_excel(
    "PYTHON数据.xlsx",
)
print(df.head())
print(df.shape)
print(df.info())





# Make a copy of the original data
clean_df = df.copy()

# Remove records where age is 999
clean_df = clean_df[clean_df["age"] != 999]

# Remove records where familiarity is 99 or 6
clean_df = clean_df[(clean_df["w5dq4"] != 99) & (clean_df["w5dq4"] != 6)]

# Check the cleaning results
print("Original number of rows:", len(df))
print("Number of rows after cleaning:", len(clean_df))
print("Number of rows removed:", len(df) - len(clean_df))
print("Age = 999:", (clean_df["age"] == 999).sum())
print("Familiarity = 99:", (clean_df["w5dq4"] == 99).sum())
print("Familiarity = 6:", (clean_df["w5dq4"] == 6).sum())

#clean_df.to_excel(
#    "cleaned_data.xlsx",
#    index=False
#)





# Calculate descriptive statistics for each AI familiarity group
group_stats = clean_df.groupby("w5dq4")["age"].agg(
    ["count", "mean", "median", "var", "std", "min", "max"]
)
print(group_stats.round(2))


# Check the AI familiarity groups
#print("AI familiarity groups:")
#print(sorted(clean_df["w5dq4"].unique()))

# Check the total number of observations
#print("Total observations:", clean_df["age"].count())

# Check the number of observations in each group
#print(clean_df["w5dq4"].value_counts().sort_index())

# Check whether group counts add up to the total
#print("Sum of group counts:", group_stats["count"].sum())






import matplotlib.pyplot as plt
import seaborn as sns

sns.boxplot(
    data=clean_df,
    x="w5dq4",
    y="age",
    showmeans=True
)
plt.xlabel("AI Familiarity Group")
plt.ylabel("Age")
plt.title("Age Distribution Across AI Familiarity Groups")
plt.show()





sns.barplot(data=clean_df, x="w5dq4", y="age", 
            #errorbar=None,
            errorbar=("ci", 95))
plt.xlabel("AI Familiarity Group")
plt.ylabel("Mean Age")
plt.title("Mean Age Across AI Familiarity Groups")
plt.show()





plt.figure(figsize=(8, 5))
sns.histplot(data=clean_df, x="age", bins=20)
plt.xlabel("Age")
plt.ylabel("Number of People")
plt.title("Age Distribution of Respondents")
plt.show()





#sns.violinplot(data=clean_df, x="w5dq4", y="age")
#plt.xlabel("AI Familiarity Group")
#plt.ylabel("Age")
#plt.title("Age Distribution Across AI Familiarity Groups")
#plt.show()
