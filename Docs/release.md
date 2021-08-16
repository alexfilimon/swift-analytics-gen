# Before creating PR

1. Ensure all TODO's are deleted
2. Script successfully bulding and running (delete `output` folder and check if it exists after running)

# After merging PR

1. Checkout and actualize `master` branch 
2. Ensure You have write access to repository
3. Run `make executable V={new_version}` in terminal
4. Ensure that github actions succeded
