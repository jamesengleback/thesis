# Thesis

WIP

## Recently Changed

- [update vde methods section](methods-evo.md) - 2022-02-01 - added commit hashes and some detains for experiment $A$ and $B$. Removed Lab sections.
- [run and cleanup of vde](https://github.com/jamesengleback/vde) - 2022-01-30
- [cleanup of thesis repo](https://github.com/jamesengleback/thesis) - 2022-01-30
- [vde analysis notebook](evo-a-b.md) - 2022-01-25
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

        Model Assembly                          : rio7, after des5, 28d
        Pre-training data assembly              : rio8, after des5, 14d
        Model Pre-training                      : rio9, after des5, 19d
        Model Training                          : rio10, after rio2, 4d
        Test Model Mutant Design                : rio11, after rio10, 4d
        Model Screen Design                     : rio12, after rio10, 4d

        General Introduction                    : wr9, after wr5, 25d
```

## vde
- [x] vde - [**Exp a & b**](https://github.com/jamesengleback/vde)
- [ ] vde - [**methods**](methods-evo.md) 
- [ ] vde - [**analysis**](evo-a-b.md) 
- [ ] vde - [**results**](results-evo.md)
- [ ] vde - [**discussion**](discussion-evo.md)

## screening-fist
- [ ] screening-fist - `design.ipynb`  
- [ ] screening-fist - dump screen
- [ ] screening-fist - model pretraining data
- [ ] screening-fist - model
- [ ] screening-fist - train
- [ ] screening-fist - [**methods**](methods-rio.md)
- [ ] screening-fist - [**analysis**](analysis-rio.md)
- [ ] screening-fist - [**results**](results-rio.md)
- [ ] screening-fist - [**discussion**](discussion-rio.md)



## Contributiing
[**Project Github Page**](https://github.com/jamesengleback/thesis)

!!! info "help"
	see [contributing](contributing.md) for info on suggesting edits etc via github

