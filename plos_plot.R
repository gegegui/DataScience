library("rplos")
dic = c("linear regression","Lasso","ridge regression","linear discriminant analysis","bootstrap","maximum likelihood","MCMC","neural network","support vector machine","clustering","principal component","independent component","random forest","graphical model", "Kaplan", "Cox proportional")
# "EM algorithm",

s = rep(NA, length(dic))
for (i in 1:length(dic)){
  id = searchplos(paste("abstract:", dic[i]), fl='id, publication_date', fq='doc_type:full', sort = 'publication_date desc', start=0)
  s[i] = id$meta$numFound
}

dic2 = dic[order(s)]
s2 = sort(s)
df = data.frame(dic2, s2)
df1 = df[1:round(nrow(df)/2),]
df2 = df[(round(nrow(df)/2) + 1) : nrow(df),]

library("ggplot2")
p = ggplot(data=df, aes(x= reorder(dic2, -s2), y=s2, fill = reorder(dic2, -s2))) + geom_bar(stat="identity")
p + coord_flip() + labs(x = "count in paper", y = "statistical topics", fill = "statistical topics") + geom_text(aes(label = s2), size = 3,  hjust = -0.5, position = position_dodge(width = 1),) + ylim(0, max(s) + 1000) 
# position ="stack", hjust = 0.5, vjust = 3,


# a = plosword(dic, vis = 'TRUE')
# a$plot + coord_flip()
