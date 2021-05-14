describe('Games list', () => {
  beforeEach(() => {
    cy.intercept('GET', '**/games.json', { fixture: 'games.json' })
    cy.visit('/')
  });

  it('has a title in the page', () => {
    cy.get('div.main-title').should('contain', 'My Mega Drive collection');
  });

  it('returns one game per row', () => {
    cy.get('table tbody')
      .find('tr').should('have.length', 20);
  });
});
