from rdkit import Chem
from rdkit.Chem import Draw

def draw_chem(smiles, out_path):
    mol = Chem.MolFromSmiles(smiles)
    im = Draw.MolToImage(mol)
    im.save(out_path)

def main():
    mesotrine = 'CS(=O)(=O)C1=CC(=C(C=C1)C(=O)C2C(=O)CCCC2=O)[N+](=O)[O-]'
    draw_chem(mesotrine, 'mesotrione.png')

if __name__ == '__main__':
    main()
