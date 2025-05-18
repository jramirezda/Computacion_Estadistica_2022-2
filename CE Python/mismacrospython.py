import pandas as pd

def onewayfreq(rows,data,weight=None,cum=True,ord="level",subset=None):
    if weight is None: weight = 1
    else: weight = data[weight] 
    if subset != None: data = data.query(subset,engine="python")    
    out = (pd.crosstab(index=data[rows],values=weight,aggfunc="sum",columns="sum").reset_index()
           .rename(columns={"sum":"Frequency"})
           .eval("Percent=100*Frequency/Frequency.sum()",engine="python")
          )
    if ord == "freq": out = out.sort_values(by=["Frequency"],ascending=False).reset_index(drop=True)    
    if ord == "-freq": out = out.sort_values(by=["Frequency"],ascending=True).reset_index(drop=True)
    if ord == "-level": out = out.sort_values(by=out.columns[0],ascending=False).reset_index(drop=True) 
    if cum == True: out = out.eval('''CumulativeFrequency=Frequency.cumsum().values
                                      CumulativePercent=Percent.cumsum().values''',engine="python")
    out.columns.name=""    
    return(out)

def twowayfreq(rows,columns,data,weight=None,subset=None,ord="level",percent=False,rowpercent=False,colpercent=False):
    if weight is None: weight = 1
    else: weight = data[weight] 
    if subset != None: data = data.query(subset,engine="python")    
    out = pd.crosstab(index=data[rows],values=weight,aggfunc="sum",columns=data[columns],margins=True,margins_name="Total").reset_index().fillna(0)
    p1 = out.head(n=(len(out.index)-1))
    if ord == "freq": p1 = p1.sort_values(by=["Total"],ascending=False)
    if ord == "-freq": p1 = p1.sort_values(by=["Total"],ascending=True)    
    if ord == "-level": p1 = p1.sort_values(by=out.columns[0],ascending=False)
    out = p1.append(out.tail(n=1)).reset_index(drop=True)
    ids = out.select_dtypes("number").columns
    out2 = out.copy().assign(Ind = "2")
    out3 = out.copy().assign(Ind = "3")
    out4 = out.copy().assign(Ind = "4")
    out = out.assign(Ind = "1")
    def pct(x):
        return(200*x/x.sum())
    out2[ids] = 200*out2[ids]/out2["Total"].sum()
    out3[ids] = out._get_numeric_data().apply(pct,axis=1)
    out4[ids] = out._get_numeric_data().apply(pct,axis=0)
    out = out.append(out2).append(out3).append(out4).rename_axis('MyIdx').sort_values(by=["MyIdx","Ind"])
    out.loc[out["Ind"] != "1",rows] = ""    
    print("Frequency")
    if percent == False: out = out.query("Ind != '2'")
    else: print("Percent")
    if rowpercent == False: out = out.query("Ind != '3'")    
    else: print("Row percent")        
    if colpercent == False: out = out.query("Ind != '4'")    
    else: print("Col percent")        
    out = out.drop(columns="Ind").reset_index(drop=True)
    out.columns.name=""
    out.index.names=[""]
    out = out.rename(columns={rows: rows + "  /  " + columns})
    print(" ")
    return(out)