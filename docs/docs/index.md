# Thesis

WIP

## Recently Changed

- [vde analysis notebook](evo-a-b.md) 
- [this page](index.md) - updated gantt chart 2022-01-31
- [vde methods](methods-evo.md) - vde runtime 2022-01-20

!!! info
	**vde:** no longer plan to make and test mutants in the lab - instead analyse technique

```mermaid
gantt
	title Thesis Schedule
	%dateFormat YYYY-MM-DD
	%%axisFormat %Y/%m/%d
	%%axisFormat  %Y-%m-%d


        Deadline                                : milestone deadline, 2022-03-30, 1d

        section vde
        Analysis                                : vde4, after vde2,14d
	results 				: vdereesults, after 2022-01-24, 28d
	discussion 				: vdediscussion, after 2022-01-24, 28d

        section screening-fist
        screening-design.ipynb                  : rio1, after des4, 5d
        Clean echo package                      : rio0, after des4, 4d
        dump screen          			: rio2, after rio1, 7d
        analysis                        	: rio2, after rio1, 10d
	results 				: rioreesults, after rio1, 28d
	discussion 				: riodiscussion, after rio1, 28d

        Model Assembly                          : rio7, after des5, 19d
        Pre-training data assembly              : rio8, after des5, 14d
        Model Pre-training                      : rio9, after des5, 19d
        Model Training                          : rio10, after rio2, 4d
        Test Model Mutant Design                : rio11, after rio10, 4d
        Model Screen Design                     : rio12, after rio10, 4d

        General Introduction                    : wr9, after wr5, 25d
```

### vde
- [x] vde - **Exp a & b**
- [ ] vde - **analysis** :hourglass:
- [ ] vde - **results**
- [ ] vde - **discussion**

### screening-fist
- [ ] screening-fist - `design.ipynb`  :hourglass:
- [ ] screening-fist - dump screen
- [ ] screening-fist - model pretraining data
- [ ] screening-fist - model
- [ ] screening-fist - train
- [ ] screening-fist - **analysis**
- [ ] screening-fist - **results**
- [ ] screening-fist - **discussion**



[:fontawesome-brands-github: **Project Github Page**](https://github.com/jamesengleback/thesis)

!!! info "help"
	:fontawesome-solid-edit: see [contributing](contributing.md) for info on suggesting edits etc via github

